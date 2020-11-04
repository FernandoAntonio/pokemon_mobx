import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:novo/app/app_controller.dart';
import 'package:novo/app/models/pokemons_model.dart';
import 'package:novo/app/repositories/main_repository.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  _HomeControllerBase(this.repository, this.appController){
    getPokemons();
  }

  final MainRepository repository;
  final AppController appController;

  @observable
  ObservableFuture<Pokemons> pokemons;

  @action
  setNomeCliente(value) => appController.nomeCliente = value;

  @action
  setSobrenomeCliente(value) => appController.sobrenomeCliente = value;

  @action
  getPokemons() async{
     pokemons = repository.getPokemons().asObservable();
  }
}
