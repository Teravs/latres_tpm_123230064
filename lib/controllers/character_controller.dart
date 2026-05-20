import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/character_model.dart';

class CharacterController extends GetxController {
  var characterList = <CharacterModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchCharacters();
    super.onInit();
  }

  Future<void> fetchCharacters() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(
          'https://potterapi-fedeperin.vercel.app/en/characters',
        ),
      );

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        characterList.value =
            data.map((e) => CharacterModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}