import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/spell_model.dart';

class SpellController extends GetxController {
  var spellList = <SpellModel>[].obs;

  var isLoading = false.obs;

  var refreshFavorite = false.obs;

  final Box favoriteBox =
      Hive.box('favorite_spells');

  @override
  void onInit() {
    fetchSpells();
    super.onInit();
  }

  Future<void> fetchSpells() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(
          'https://potterapi-fedeperin.vercel.app/en/spells',
        ),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        spellList.value = data
            .map(
              (e) => SpellModel.fromJson(e),
            )
            .toList();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite(String spellName) {
    refreshFavorite.value;

    return favoriteBox.containsKey(spellName);
  }

  void toggleFavorite(SpellModel spell) {
    if (favoriteBox.containsKey(spell.spell)) {
      favoriteBox.delete(spell.spell);

      Get.snackbar(
        "Remove!",
        "${spell.spell} removed from favorite",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      favoriteBox.put(
        spell.spell,
        {
          "spell": spell.spell,
          "use": spell.use,
        },
      );

      Get.snackbar(
        "Add!",
        "${spell.spell} added to favorite",
        snackPosition: SnackPosition.TOP,
      );
    }

    refreshFavorite.toggle();
  }
}