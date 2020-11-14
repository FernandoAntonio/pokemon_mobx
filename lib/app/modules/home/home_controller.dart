import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pokemon_mobx/app/app_controller.dart';
import 'package:pokemon_mobx/app/models/pokemons_model.dart';
import 'package:pokemon_mobx/app/repositories/main_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase(this.repository, this.appController) {
    getPokemons();
  }
  final MainRepository repository;
  final AppController appController;

  @observable
  ObservableFuture<Pokemons> pokemons;

  @action
  getPokemons() async => pokemons = repository.getPokemons().asObservable();
}
