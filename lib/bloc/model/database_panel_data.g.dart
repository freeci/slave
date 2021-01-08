// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_panel_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DatabasePanelData extends DatabasePanelData {
  @override
  final String panelUUID;
  @override
  final NewConnectionData connection;
  @override
  final BaseKeyDetail keyDetail;
  @override
  final String selectedKey;
  @override
  final BuiltList<String> scanKeyList;

  factory _$DatabasePanelData(
          [void Function(DatabasePanelDataBuilder) updates]) =>
      (new DatabasePanelDataBuilder()..update(updates)).build();

  _$DatabasePanelData._(
      {this.panelUUID,
      this.connection,
      this.keyDetail,
      this.selectedKey,
      this.scanKeyList})
      : super._();

  @override
  DatabasePanelData rebuild(void Function(DatabasePanelDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DatabasePanelDataBuilder toBuilder() =>
      new DatabasePanelDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DatabasePanelData &&
        panelUUID == other.panelUUID &&
        connection == other.connection &&
        keyDetail == other.keyDetail &&
        selectedKey == other.selectedKey &&
        scanKeyList == other.scanKeyList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, panelUUID.hashCode), connection.hashCode),
                keyDetail.hashCode),
            selectedKey.hashCode),
        scanKeyList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DatabasePanelData')
          ..add('panelUUID', panelUUID)
          ..add('connection', connection)
          ..add('keyDetail', keyDetail)
          ..add('selectedKey', selectedKey)
          ..add('scanKeyList', scanKeyList))
        .toString();
  }
}

class DatabasePanelDataBuilder
    implements Builder<DatabasePanelData, DatabasePanelDataBuilder> {
  _$DatabasePanelData _$v;

  String _panelUUID;
  String get panelUUID => _$this._panelUUID;
  set panelUUID(String panelUUID) => _$this._panelUUID = panelUUID;

  NewConnectionDataBuilder _connection;
  NewConnectionDataBuilder get connection =>
      _$this._connection ??= new NewConnectionDataBuilder();
  set connection(NewConnectionDataBuilder connection) =>
      _$this._connection = connection;

  BaseKeyDetail _keyDetail;
  BaseKeyDetail get keyDetail => _$this._keyDetail;
  set keyDetail(BaseKeyDetail keyDetail) => _$this._keyDetail = keyDetail;

  String _selectedKey;
  String get selectedKey => _$this._selectedKey;
  set selectedKey(String selectedKey) => _$this._selectedKey = selectedKey;

  ListBuilder<String> _scanKeyList;
  ListBuilder<String> get scanKeyList =>
      _$this._scanKeyList ??= new ListBuilder<String>();
  set scanKeyList(ListBuilder<String> scanKeyList) =>
      _$this._scanKeyList = scanKeyList;

  DatabasePanelDataBuilder();

  DatabasePanelDataBuilder get _$this {
    if (_$v != null) {
      _panelUUID = _$v.panelUUID;
      _connection = _$v.connection?.toBuilder();
      _keyDetail = _$v.keyDetail;
      _selectedKey = _$v.selectedKey;
      _scanKeyList = _$v.scanKeyList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DatabasePanelData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DatabasePanelData;
  }

  @override
  void update(void Function(DatabasePanelDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DatabasePanelData build() {
    _$DatabasePanelData _$result;
    try {
      _$result = _$v ??
          new _$DatabasePanelData._(
              panelUUID: panelUUID,
              connection: _connection?.build(),
              keyDetail: keyDetail,
              selectedKey: selectedKey,
              scanKeyList: _scanKeyList?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'connection';
        _connection?.build();

        _$failedField = 'scanKeyList';
        _scanKeyList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'DatabasePanelData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$StringKeyDetail extends StringKeyDetail {
  @override
  final String value;
  @override
  final String newValue;
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$StringKeyDetail([void Function(StringKeyDetailBuilder) updates]) =>
      (new StringKeyDetailBuilder()..update(updates)).build();

  _$StringKeyDetail._(
      {this.value, this.newValue, this.key, this.type, this.ttl})
      : super._();

  @override
  StringKeyDetail rebuild(void Function(StringKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StringKeyDetailBuilder toBuilder() =>
      new StringKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StringKeyDetail &&
        value == other.value &&
        newValue == other.newValue &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, value.hashCode), newValue.hashCode), key.hashCode),
            type.hashCode),
        ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StringKeyDetail')
          ..add('value', value)
          ..add('newValue', newValue)
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class StringKeyDetailBuilder
    implements Builder<StringKeyDetail, StringKeyDetailBuilder> {
  _$StringKeyDetail _$v;

  String _value;
  String get value => _$this._value;
  set value(String value) => _$this._value = value;

  String _newValue;
  String get newValue => _$this._newValue;
  set newValue(String newValue) => _$this._newValue = newValue;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  StringKeyDetailBuilder();

  StringKeyDetailBuilder get _$this {
    if (_$v != null) {
      _value = _$v.value;
      _newValue = _$v.newValue;
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StringKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$StringKeyDetail;
  }

  @override
  void update(void Function(StringKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StringKeyDetail build() {
    final _$result = _$v ??
        new _$StringKeyDetail._(
            value: value, newValue: newValue, key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$HashKeyDetail extends HashKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$HashKeyDetail([void Function(HashKeyDetailBuilder) updates]) =>
      (new HashKeyDetailBuilder()..update(updates)).build();

  _$HashKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  HashKeyDetail rebuild(void Function(HashKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HashKeyDetailBuilder toBuilder() => new HashKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HashKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HashKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class HashKeyDetailBuilder
    implements Builder<HashKeyDetail, HashKeyDetailBuilder> {
  _$HashKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  HashKeyDetailBuilder();

  HashKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HashKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$HashKeyDetail;
  }

  @override
  void update(void Function(HashKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HashKeyDetail build() {
    final _$result =
        _$v ?? new _$HashKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$ListKeyDetail extends ListKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$ListKeyDetail([void Function(ListKeyDetailBuilder) updates]) =>
      (new ListKeyDetailBuilder()..update(updates)).build();

  _$ListKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  ListKeyDetail rebuild(void Function(ListKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListKeyDetailBuilder toBuilder() => new ListKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class ListKeyDetailBuilder
    implements Builder<ListKeyDetail, ListKeyDetailBuilder> {
  _$ListKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  ListKeyDetailBuilder();

  ListKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListKeyDetail;
  }

  @override
  void update(void Function(ListKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListKeyDetail build() {
    final _$result =
        _$v ?? new _$ListKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$SetKeyDetail extends SetKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$SetKeyDetail([void Function(SetKeyDetailBuilder) updates]) =>
      (new SetKeyDetailBuilder()..update(updates)).build();

  _$SetKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  SetKeyDetail rebuild(void Function(SetKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetKeyDetailBuilder toBuilder() => new SetKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SetKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class SetKeyDetailBuilder
    implements Builder<SetKeyDetail, SetKeyDetailBuilder> {
  _$SetKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  SetKeyDetailBuilder();

  SetKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SetKeyDetail;
  }

  @override
  void update(void Function(SetKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SetKeyDetail build() {
    final _$result =
        _$v ?? new _$SetKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

class _$ZSetKeyDetail extends ZSetKeyDetail {
  @override
  final String key;
  @override
  final String type;
  @override
  final int ttl;

  factory _$ZSetKeyDetail([void Function(ZSetKeyDetailBuilder) updates]) =>
      (new ZSetKeyDetailBuilder()..update(updates)).build();

  _$ZSetKeyDetail._({this.key, this.type, this.ttl}) : super._();

  @override
  ZSetKeyDetail rebuild(void Function(ZSetKeyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ZSetKeyDetailBuilder toBuilder() => new ZSetKeyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ZSetKeyDetail &&
        key == other.key &&
        type == other.type &&
        ttl == other.ttl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, key.hashCode), type.hashCode), ttl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ZSetKeyDetail')
          ..add('key', key)
          ..add('type', type)
          ..add('ttl', ttl))
        .toString();
  }
}

class ZSetKeyDetailBuilder
    implements Builder<ZSetKeyDetail, ZSetKeyDetailBuilder> {
  _$ZSetKeyDetail _$v;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

  int _ttl;
  int get ttl => _$this._ttl;
  set ttl(int ttl) => _$this._ttl = ttl;

  ZSetKeyDetailBuilder();

  ZSetKeyDetailBuilder get _$this {
    if (_$v != null) {
      _key = _$v.key;
      _type = _$v.type;
      _ttl = _$v.ttl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ZSetKeyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ZSetKeyDetail;
  }

  @override
  void update(void Function(ZSetKeyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ZSetKeyDetail build() {
    final _$result =
        _$v ?? new _$ZSetKeyDetail._(key: key, type: type, ttl: ttl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
