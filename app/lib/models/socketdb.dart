import 'package:realm/realm.dart';

part 'socketdb.g.dart';

@RealmModel()
class _SocketDB {
  @PrimaryKey()
  late final ObjectId id;

  String url = 'https://panel.baspar.vazir.io/';
}
