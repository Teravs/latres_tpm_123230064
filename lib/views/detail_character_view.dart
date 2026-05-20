import 'package:flutter/material.dart';

import '../models/character_model.dart';

class DetailCharacterView extends StatelessWidget {
  final CharacterModel character;

  const DetailCharacterView({
    super.key,
    required this.character,
  });

  Widget item(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(value.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.fullName ?? '-'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                character.image ?? '',
                height: 300,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    size: 150,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            item("Full Name", character.fullName),
            item("Nickname", character.nickname),
            item("House", character.hogwartsHouse),
            item("Actor", character.interpretedBy),
            item("Birthdate", character.birthdate),
            item("Children", character.children),
          ],
        ),
      ),
    );
  }
}