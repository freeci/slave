package redis_plugin

import (
	"errors"
	"fmt"
	"log"
	"net"
	"strings"

	redigo "github.com/garyburd/redigo/redis"
	flutter "github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/go-flutter/plugin"
)

const channelName = "plugins.redishouse.com/redis-plugin"

type RedisPlugin struct {
	channel *plugin.MethodChannel
}

var _ flutter.Plugin = &RedisPlugin{}
var pool_size = 20

type Connection struct {
	id                    string
	name                  string
	useSSLTLS             bool
	useSSHTunnel          bool
	useSSHPrivateKey      bool
	redisName             string
	redisAddress          string
	redisPort             string
	redisPassword         string
	sshAddress            string
	sshPassword           string
	sshPort               string
	sshUser               string
	sshPrivateKey         string
	sshPrivateKeyPassword string
}

type Session struct {
	ID     string
	Conn   redigo.Conn
}

var poolsMap map[string]*redigo.Pool = make(map[string]*redigo.Pool)
var poolsSessionsMap map[string]map[string]Session = make(map[string]map[string]Session)

func (p *RedisPlugin) InitPlugin(messenger plugin.BinaryMessenger) error {

	p.channel = plugin.NewMethodChannel(messenger, channelName, plugin.StandardMethodCodec{})
	p.channel.HandleFunc("connectTo", connectTo)
	p.channel.HandleFunc("createSession", createSession)
	p.channel.HandleFunc("closeSession", closeSession)
	p.channel.HandleFunc("ping", ping)
	p.channel.HandleFunc("do", do)
	p.channel.HandleFunc("close", close)
	p.channel.HandleFunc("getError", getErrorFunc)
	p.channel.CatchAllHandleFunc(catchAllTest)
	return nil // no error
}

func connectTo(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; ok {
		return
	}
	if nil != err {
		log.Printf("get ssh client err: %v\n", err)
		return nil, err
	}

	redisAddr := fmt.Sprintf("%s:%s", argsMap["redisAddress"].(string), argsMap["redisPort"].(string))

	var conn net.Conn = nil
	if _, ok := argsMap["useSSHTunnel"]; ok && argsMap["useSSHTunnel"].(bool) {

		client, err := getSSHClient(argsMap)
		if err != nil {
			log.Fatal("dial to redis addr err: ", err)
			return nil, err
		}
		conn, err = client.Dial("tcp", redisAddr)
	}

	pool := redigo.NewPool(
		func() (redigo.Conn, error) {

			var c redigo.Conn
			if conn != nil {
				c = redigo.NewConn(conn, -1, -1)
			} else {
				c, err = redigo.Dial("tcp", redisAddr)
			}

			if err != nil {
				return nil, err
			}

			if _, ok := argsMap["redisPassword"]; ok && argsMap["redisPassword"].(string) != "" {
				if _, err := c.Do("AUTH", argsMap["redisPassword"].(string)); err != nil {
					c.Close()
					return nil, err
				}
			}

			if _, ok := argsMap["redisDB"]; ok {
				if _, err := c.Do("SELECT", argsMap["redisDB"].(int)); err != nil {
					c.Close()
					return nil, err
				}
			}

			return c, nil
		}, pool_size)

	redisConn := pool.Get()

	pong, err := redisConn.Do("ping")
	if err != nil || pong.(string) != "PONG" {
		log.Fatal("redis connect failed", err)
		return nil, err
	}
	redisConn.Close()

	poolsMap[argsMap["id"].(string)] = pool
	return
}

func createSession(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; !ok {
		return false, errors.New("pool 不存在！")
	}

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; !ok {
		poolsSessionsMap[argsMap["id"].(string)] = make(map[string]Session)
	}

	sessionsMap := poolsSessionsMap[argsMap["id"].(string)]
	if _, ok := sessionsMap[argsMap["sessionID"].(string)]; ok {
		return nil, errors.New("sessionID 已存在！")
	}

	pool := poolsMap[argsMap["id"].(string)]
	redisConn := pool.Get()

	sessionsMap[argsMap["sessionID"].(string)] = Session{
		ID:   argsMap["sessionID"].(string),
		Conn: redisConn,
	}
	return nil, nil
}

func closeSession(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; !ok {
		return false, errors.New("pool 不存在！")
	}

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; !ok {
		poolsSessionsMap[argsMap["id"].(string)] = make(map[string]Session)
	}

	sessionsMap := poolsSessionsMap[argsMap["id"].(string)]
	if _, ok := sessionsMap[argsMap["sessionID"].(string)]; !ok {
		return nil, errors.New("sessionID 不存在！")
	}
	session := sessionsMap[argsMap["sessionID"].(string)]
	session.Conn.Close()
	return nil, nil
}

func do(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; !ok {
		return false, errors.New("pool 不存在！")
	}

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; !ok {
		poolsSessionsMap[argsMap["id"].(string)] = make(map[string]Session)
	}

	sessionsMap := poolsSessionsMap[argsMap["id"].(string)]
	if _, ok := sessionsMap[argsMap["sessionID"].(string)]; !ok {
		return nil, errors.New("sessionID 不存在！")
	}

	redisConn := sessionsMap[argsMap["sessionID"].(string)].Conn

	strFields := strings.Fields(argsMap["command"].(string))
	log.Println(strFields)
	args := make([]interface{}, len(strFields)-1)
	for i, v := range strFields[1:] {
		args[i] = v
	}

	var res []string
	if len(args) == 0 {
		res, err = redigo.Strings(redisConn.Do(strFields[0]))
	} else {
		res, err = redigo.Strings(redisConn.Do(strFields[0], args...))
	}
	var sectionList = make([]interface{}, len(res))
	for i, v := range res {
		sectionList[i] = v
	}
	return sectionList, err
}

func close(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})

	if _, ok := poolsSessionsMap[argsMap["id"].(string)]; ok {
		delete(poolsSessionsMap[argsMap["id"].(string)], argsMap["id"].(string))
	}

	if _, ok := poolsMap[argsMap["id"].(string)]; ok {
		pool := poolsMap[argsMap["id"].(string)]
		err = pool.Close()
		if err != nil {
			return nil, err
		}
		delete(poolsMap, argsMap["id"].(string))
	}
	return nil, err
}

func ping(arguments interface{}) (reply interface{}, err error) {

	argsMap := arguments.(map[interface{}]interface{})
	if _, ok := poolsMap[argsMap["id"].(string)]; ok {
		return
	}
	if nil != err {
		log.Printf("get ssh client err: %v\n", err)
		return nil, err
	}

	redisAddr := fmt.Sprintf("%s:%s", argsMap["redisAddress"].(string), argsMap["redisPort"].(string))
	var conn net.Conn = nil
	if _, ok := argsMap["useSSHTunnel"]; ok && argsMap["useSSHTunnel"].(bool) {

		client, err := getSSHClient(argsMap)
		if err != nil {
			log.Fatal("dial to redis addr err: ", err)
			return nil, err
		}
		conn, err = client.Dial("tcp", redisAddr)
	}

	var c redigo.Conn
	if conn != nil {
		c = redigo.NewConn(conn, -1, -1)
	} else {
		c, err = redigo.Dial("tcp", redisAddr)
	}

	if _, ok := argsMap["redisPassword"]; ok && argsMap["redisPassword"].(string) != "" {
		if _, err := c.Do("AUTH", argsMap["redisPassword"].(string)); err != nil {
			c.Close()
			return nil, err
		}
	}

	pong, err := c.Do("ping")
	if err != nil || pong.(string) != "PONG" {
		log.Fatal("redis connect failed", err)
		return nil, err
	}
	return
}

func catchAllTest(methodCall interface{}) (reply interface{}, err error) {
	method := methodCall.(plugin.MethodCall)
	// return the randomized Method Name
	return method.Method, nil
}

func getErrorFunc(arguments interface{}) (reply interface{}, err error) {
	return nil, plugin.NewError("customErrorCode", errors.New("Some error"))
}


