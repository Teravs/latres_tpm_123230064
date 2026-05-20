class SpellModel {
  String? spell;
  String? use;

  SpellModel({
    this.spell,
    this.use,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) {
    return SpellModel(
      spell: json['spell'],
      use: json['use'],
    );
  }
}