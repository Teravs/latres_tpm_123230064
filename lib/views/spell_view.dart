import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/spell_controller.dart';
import '../models/spell_model.dart';
import 'character_view.dart';
import 'favorite_spell_view.dart';
import 'login_view.dart';

class SpellView extends StatelessWidget {
  SpellView({super.key});

  final SpellController controller =
      Get.put(SpellController());

  Future<void> logout() async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove('isLogin');

    Get.offAll(() => LoginView());

    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        Get.snackbar(
          "Success!",
          "Logged out Successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F2FA),

      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text("Harry Potter Spells"),

        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

            body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.spellList.length,

                itemBuilder: (context, index) {
                  SpellModel spell =
                      controller.spellList[index];

                  return Obx(() {
                    bool isFav = controller.isFavorite(
                      spell.spell ?? '',
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      child: Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.auto_fix_high,
                          ),

                          title: Text(
                            spell.spell ?? '-',
                          ),

                          subtitle: Text(
                            spell.use ?? '-',
                          ),

                          trailing: IconButton(
                            onPressed: () {
                              controller.toggleFavorite(
                                spell,
                              );
                            },

                            icon: Icon(
                              Icons.favorite,
                              color: isFav
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),

              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    Get.off(() => CharacterView());
                  },

                  child: const Text("Characters"),
                ),
              ),
            ),
          ],
        );
      }),

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 70,
        ),

        child: SizedBox(
          width: 55,
          height: 55,

          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => FavoriteSpellView());
            },

            child: const Icon(
              Icons.favorite,
            ),
          ),
        ),
      ),
    );
  }
}