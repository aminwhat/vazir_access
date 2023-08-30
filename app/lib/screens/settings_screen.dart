import 'package:app/models/socketdb.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController controller;
  late Realm realm;

  @override
  void initState() {
    realm = Realm(Configuration.local([SocketDB.schema]));
    String text = 'empty';
    try {
      text = realm.all<SocketDB>().first.url;
    } catch (e) {}
    controller = TextEditingController(text: text);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    realm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
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
                const SizedBox(height: 40),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(hintText: 'Server Address'),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white54),
                  ),
                  onPressed: () {
                    realm.write(() {
                      realm.deleteAll<SocketDB>();
                      realm.add<SocketDB>(
                        SocketDB(
                          ObjectId(),
                          url: controller.value.text.trim(),
                        ),
                      );
                    });
                    Snacks.success();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
