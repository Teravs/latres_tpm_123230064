import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';

class FavoriteSpellView extends StatelessWidget {
  FavoriteSpellView({super.key});

  final Box favoriteBox =
      Hive.box('favorite_spells');

  Future<void> showNotification(
    String spellName,
  ) async {
    const AndroidNotificationDetails
        androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'favorite_spell_channel',
      'Favorite Spell',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails
        platformChannelSpecifics =
        NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Delete notification',
      'You deleted $spellName from fav list',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F2FA,
      ),

      appBar: AppBar(
        title: const Text(
          "Favorite Spell",
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable:
            favoriteBox.listenable(),

        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                "No Favorite Spell",
              ),
            );
          }

          return ListView.builder(
            itemCount: box.length,

            itemBuilder: (context, index) {
              var data = box.getAt(index);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                child: Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.auto_fix_high,
                    ),

                    title: Text(
                      data['spell'] ?? '-',
                    ),

                    subtitle: Text(
                      data['use'] ?? '-',
                    ),

                    trailing: IconButton(
                      onPressed: () async {
                        String spellName =
                            data['spell'];

                        await favoriteBox.deleteAt(
                          index,
                        );

                        await showNotification(
                          spellName,
                        );
                      },

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}