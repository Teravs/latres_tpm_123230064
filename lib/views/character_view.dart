import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/character_controller.dart';
import '../models/character_model.dart';
import 'detail_character_view.dart';
import 'login_view.dart';
import 'spell_view.dart';

class CharacterView extends StatelessWidget {
  CharacterView({super.key});

  final CharacterController controller =
      Get.put(CharacterController());

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
        title: const Text("Harry Potter Character Galery"),

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
                itemCount: controller.characterList.length,

                itemBuilder: (context, index) {
                  CharacterModel character =
                      controller.characterList[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    child: Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),

                          child: Image.network(
                            character.image ?? '',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,

                            errorBuilder:
                                (context, error, stackTrace) {
                              return const Icon(Icons.person);
                            },
                          ),
                        ),

                        title: Text(
                          character.fullName ?? '-',
                        ),

                        subtitle: Text(
                          character.interpretedBy ?? '-',
                        ),

                        onTap: () {
                          Get.to(
                            () => DetailCharacterView(
                              character: character,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),

              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => SpellView());
                  },

                  child: const Text("Spells"),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}