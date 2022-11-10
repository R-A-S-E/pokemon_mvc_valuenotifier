import 'dart:convert';

class SelectPokemonModel {
  final int id;
  final String name;
  final int height;
  final int weight;
  final String image;
  SelectPokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.image,
  });

  SelectPokemonModel copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    String? image,
  }) {
    return SelectPokemonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'image': image,
    };
  }

  factory SelectPokemonModel.fromMap(Map<String, dynamic> map) {
    return SelectPokemonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      height: map['height'] as int,
      weight: map['weight'] as int,
      image: map['sprites']['front_default'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectPokemonModel.fromJson(String source) =>
      SelectPokemonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SelectPokemonModel(id: $id, name: $name, height: $height, weight: $weight, image: $image)';
  }

  @override
  bool operator ==(covariant SelectPokemonModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.height == height &&
        other.weight == weight &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        height.hashCode ^
        weight.hashCode ^
        image.hashCode;
  }
}
