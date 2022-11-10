import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:state_project/src/pages/home/models/pokemon_model.dart';
import 'package:state_project/src/pages/home/models/select_pokemon_model.dart';
import 'package:state_project/src/services/current_state.dart';

class HomeController {
  List<PokemonModel> pokemons = [];
  List<SelectPokemonModel> selectedPokemon = [];
  ValueNotifier<CurrentStatus> currentState =
      ValueNotifier<CurrentStatus>(CurrentStatus.empty);
  ValueNotifier<CurrentStatus> currentStateSelectPokemon =
      ValueNotifier<CurrentStatus>(CurrentStatus.empty);

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

  void onSelectPokemon(String url) async {
    currentStateSelectPokemon.value = CurrentStatus.loading;
    var data = await selectPokemon(url);
    if (data != null) {
      selectedPokemon.add(data);
      if (selectedPokemon.length > 5) {
        currentStateSelectPokemon.value = CurrentStatus.failed;
      } else {
        currentStateSelectPokemon.value = CurrentStatus.success;
      }
    } else {
      currentStateSelectPokemon.value = CurrentStatus.failed;
    }
  }

  void initPokemon() async {
    currentState.value = CurrentStatus.loading;
    var data = await getPokemon();
    if (data != null && data.isNotEmpty) {
      pokemons.addAll(data);
      currentState.value = CurrentStatus.success;
    } else {
      currentState.value = CurrentStatus.failed;
    }
  }
}
