import 'package:dio/dio.dart';
import 'package:state_project/src/pages/home/models/pokemon_model.dart';
import 'package:state_project/src/pages/home/models/select_pokemon_model.dart';

class HomeRepository {
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
}
