import 'package:app/models/socketdb.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  var realm = Realm(Configuration.local([SocketDB.schema]));
                  realm.write(() {
                    realm.deleteAll<SocketDB>();
                  });
                  realm.close();
                  Snacks.success();
                },
                child: const Text('Clear Cache'),
              ),
            ],
          ),
        ));
  }
}
