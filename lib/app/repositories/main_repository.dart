import 'package:dio/dio.dart';
import 'package:pokemon_mobx/app/models/pokemons_model.dart';
import 'package:pokemon_mobx/app/shared/constants.dart';

class MainRepository {
  MainRepository(this.dio);

  final Dio dio;

  Future<Pokemons> getPokemons() async {
    try {
      Response response = await dio.get(apiBaseUrl + methodGetPokemons);

      if (response.statusCode == 200) {
        Pokemons pokemons = Pokemons.fromJson(response.data);

        return pokemons;
      }
    } on DioError catch (e) {
      print(e);
    }

    return null;
  }
}
