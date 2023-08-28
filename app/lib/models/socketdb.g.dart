// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socketdb.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class SocketDB extends _SocketDB
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  SocketDB(
    ObjectId id, {
    String url = 'http://localhost:3781/power',
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<SocketDB>({
        'url': 'http://localhost:3781/power',
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'url', url);
  }

  SocketDB._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get url => RealmObjectBase.get<String>(this, 'url') as String;
  @override
  set url(String value) => RealmObjectBase.set(this, 'url', value);

  @override
  Stream<RealmObjectChanges<SocketDB>> get changes =>
      RealmObjectBase.getChanges<SocketDB>(this);

  @override
  SocketDB freeze() => RealmObjectBase.freezeObject<SocketDB>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SocketDB._);
    return const SchemaObject(ObjectType.realmObject, SocketDB, 'SocketDB', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('url', RealmPropertyType.string),
    ]);
  }
}
