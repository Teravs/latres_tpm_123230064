class CharacterModel {
  String? fullName;
  String? nickname;
  String? hogwartsHouse;
  String? interpretedBy;
  List<String>? children;
  String? image;
  String? birthdate;

  CharacterModel({
    this.fullName,
    this.nickname,
    this.hogwartsHouse,
    this.interpretedBy,
    this.children,
    this.image,
    this.birthdate,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      fullName: json['fullName'],
      nickname: json['nickname'],
      hogwartsHouse: json['hogwartsHouse'],
      interpretedBy: json['interpretedBy'],
      children: json['children'] == null
          ? []
          : List<String>.from(json['children']),
      image: json['image'],
      birthdate: json['birthdate'],
    );
  }
}