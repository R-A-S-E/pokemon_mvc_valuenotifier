import 'package:flutter/material.dart';
import 'package:state_project/src/pages/home/models/pokemon_model.dart';
import 'package:state_project/src/pages/home/models/select_pokemon_model.dart';
import 'package:state_project/src/pages/home/repositorios/home_repository.dart';
import 'package:state_project/src/services/current_state.dart';

class HomeController {
  final HomeRepository repository;
  HomeController(this.repository);
  List<PokemonModel> pokemons = [];
  List<SelectPokemonModel> selectedPokemon = [];
  ValueNotifier<CurrentStatus> currentState =
      ValueNotifier<CurrentStatus>(CurrentStatus.empty);
  ValueNotifier<CurrentStatus> currentStateSelectPokemon =
      ValueNotifier<CurrentStatus>(CurrentStatus.empty);

  void onSelectPokemon(String url) async {
    currentStateSelectPokemon.value = CurrentStatus.loading;
    var data = await repository.selectPokemon(url);
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
    var data = await repository.getPokemon();
    if (data != null && data.isNotEmpty) {
      pokemons.addAll(data);
      currentState.value = CurrentStatus.success;
    } else {
      currentState.value = CurrentStatus.failed;
    }
  }
}
