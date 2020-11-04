import 'package:dio/dio.dart';
import 'package:novo/app/models/pokemons_model.dart';
import 'package:novo/app/shared/constants.dart';

class MainRepository {
  MainRepository(this.dio);

  final Dio dio;

  Future<Pokemons> getPokemons() async {
    try {
      Response response = await dio.get(API_BASE_URL + methodGetPokemons);

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
