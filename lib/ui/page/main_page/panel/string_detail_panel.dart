
import 'dart:async';

import 'package:after_init/after_init.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndialog/ndialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redis_house/bloc/database_panel_bloc.dart';
import 'package:redis_house/bloc/model/database_panel_data.dart';
import 'package:redis_house/log/log.dart';
import 'package:redis_house/plugin/redis_plugin/redis.dart';
import 'package:redis_house/util/string_util.dart';

class StringDetailPanel extends StatefulWidget {
  final String keyName;
  StringDetailPanel(this.keyName) : super(key: ValueKey(keyName));
  @override
  State<StatefulWidget> createState() {
    return _StringDetailPanelState();
  }
}

class _StringDetailPanelState extends State<StringDetailPanel> with AfterInitMixin<StringDetailPanel> {

  TextEditingController _keyEditingController = TextEditingController();
  TextEditingController _valueEditingController = TextEditingController();

  TextEditingController _renameTextEditingController = TextEditingController();
  TextEditingController _ttlTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueEditingController.addListener(_valueChanged);
  }

  StreamSubscription keyDetailStreamSubscription;
  @override
  void didInitState() {
    keyDetailStreamSubscription = BlocProvider.of<DatabasePanelBloc>(context).listen((DatabasePanelData data) {
      if(mounted && data != null && data.keyDetail != null && data.keyDetail is StringKeyDetail) {
        StringKeyDetail keyDetail = data.keyDetail;
        _keyEditingController.text = keyDetail.key;
        _renameTextEditingController.text = keyDetail.key;
        _ttlTextEditingController.text = "${keyDetail.ttl}";
      }
    });
    StringKeyDetail keyDetail = context.read<DatabasePanelBloc>().state.keyDetail;
    _keyEditingController.text = keyDetail.key;
    _valueEditingController.text = keyDetail.value;
    _renameTextEditingController.text = keyDetail.key;
    _ttlTextEditingController.text = "${keyDetail.ttl}";
  }

  @override
  void dispose() {
    super.dispose();
    keyDetailStreamSubscription?.cancel();
    _keyEditingController?.dispose();
    _valueEditingController?.removeListener(_valueChanged);
    _valueEditingController?.dispose();
    _renameTextEditingController?.dispose();
    _ttlTextEditingController?.dispose();
  }

  void _valueChanged() {
    context.read<DatabasePanelBloc>().add(StringValueChanged(_valueEditingController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabasePanelBloc, DatabasePanelData>(
      builder: (BuildContext context, state) {
        var panelUUID = state.panelUUID;
        var connection = state.connection;
        StringKeyDetail keyDetail = state.keyDetail;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text("${state.keyDetail.type.toUpperCase()}"),
                  SizedBox(width: 10,),
                  Expanded(child: TextField(
                    readOnly: true,
                    controller: _keyEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(),
                    ),
                  )),
                  MaterialButton(
                    onPressed: () async {
                      _renameTextEditingController.text = state.keyDetail.key;
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("重命名 Key"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: TextField(
                            controller: _renameTextEditingController,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                          FlatButton(child: Text("保存", style: TextStyle(color: Colors.blue),),onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                        ],
                      ).show(context).then((value) {
                        if(value??false) {
                          Redis.instance.execute(connection.id, panelUUID, "renamenx ${state.keyDetail.key} ${_renameTextEditingController.text}").then((value) {
                            if(value == 1) {
                              context.read<DatabasePanelBloc>().add(KeyRenameEvent(state.keyDetail.key, _renameTextEditingController.text));
                              BotToast.showText(text: "重命名成功。");
                            } else {
                              BotToast.showText(text: "KEY 已存在！");
                            }
                          }).catchError((e) {
                            BotToast.showText(text: "$e");
                          });
                        }
                      });
                    },
                    child: Text("重命名"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("修改 TTL"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: TextField(
                            controller: _ttlTextEditingController,
                            minLines: 1,
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "TTL"
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                          FlatButton(child: Text("保存", style: TextStyle(color: Colors.blue),),onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                        ],
                      ).show(context).then((value) {
                        if(value??false) {
                          Redis.instance.execute(connection.id, panelUUID, " EXPIRE ${state.keyDetail.key} ${_ttlTextEditingController.text}").then((value) {
                            context.read<DatabasePanelBloc>().add(KeyTTLChanged(int.tryParse(_ttlTextEditingController.text)));
                            BotToast.showText(text: "TTL 已修改。");
                          });
                        }
                      });
                    },
                    child: Text("TTL: ${state.keyDetail.ttl}"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      NDialog(
                        dialogStyle: DialogStyle(titleDivider: true),
                        title: Text("删除 KEY"),
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                          child: Text(
                            "确定删除【${state.keyDetail.key}】？"
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(child: Text("取消", style: TextStyle(color: Colors.white),),onPressed: () {
                            Navigator.of(context).pop(false);
                          }),
                          FlatButton(child: Text("删除", style: TextStyle(color: Colors.red),),onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                        ],
                      ).show(context).then((value) {
                        if(value??false) {
                          Redis.instance.execute(connection.id, panelUUID, "del ${state.keyDetail.key}").then((value) {
                            context.read<DatabasePanelBloc>().add(KeyDelete(state.keyDetail.key));
                            BotToast.showText(text: "已删除。");
                          });
                        }
                      });
                    },
                    child: Text("删除"),
                  ),
                ],
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _valueEditingController,
                maxLines: 200,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "VALUE"
                ),
              ),
            )),
            Offstage(
              offstage: StringUtil.isEqual(keyDetail.value, _valueEditingController.text),
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 8, bottom: 8),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Redis.instance.execute(connection.id, panelUUID, "set ${keyDetail.key} ${_valueEditingController.text}").then((value) {
                      if(StringUtil.isEqual("OK", value)) {
                        context.read<DatabasePanelBloc>().add(StringNewValue(_valueEditingController.text));
                      } else {
                        BotToast.showText(text: "$value");
                      }
                    }).catchError((e) {
                      BotToast.showText(text: "$e");
                    });
                  },
                  child: Text("更新"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}