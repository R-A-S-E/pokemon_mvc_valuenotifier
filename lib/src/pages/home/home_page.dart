import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PokemonModel {
  final String name;
  final String url;
  PokemonModel({required this.name, required this.url});

  PokemonModel copyWith({
    String? name,
    String? url,
  }) {
    return PokemonModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromJson(String source) =>
      PokemonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PokemonModel(name: $name, url: $url)';

  @override
  bool operator ==(covariant PokemonModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PokemonModel> pokemons = [];
  List<SelectPokemonModel> selectedPokemon = [];

  Future<List<PokemonModel>?> getPokemon() async {
    var dio = Dio();

    try {
      var response = await dio.get('https://pokeapi.co/api/v2/pokemon');
      if (response.statusCode == 200) {
        final List<dynamic> body = await response.data['results'];

        return body.map((model) => PokemonModel.fromMap(model)).toList();
      } else {
        return null;
      }
    } on DioError {
      return null;
    } finally {
      dio.close();
    }
  }

  Future<SelectPokemonModel?> selectPokemon(String url) async {
    var dio = Dio();
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        final dynamic data = await response.data;
        return SelectPokemonModel.fromMap(data);
      } else {
        return null;
      }
    } on DioError {
      return null;
    }
  }

  void initPokemon() async {
    var data = await getPokemon();
    if (data != null && data.isNotEmpty) {
      pokemons.addAll(data);
    }
  }

  @override
  void initState() {
    super.initState();
    initPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('POKEMONS'),
        ),
        body: ListView(
          children: pokemons
              .map((e) => ListTile(
                    title: Text(e.name),
                  ))
              .toList(),
        ));
  }
}
