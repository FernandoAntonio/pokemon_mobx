import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  String formatPokemonNames(String name) {
    if (name == null || name == '') {
      return '';
    } else {
      String formattedName = name.replaceAll('-', ' ');
      formattedName = name
          .split(' ')
          .map((string) => string[0].toUpperCase() + string.substring(1))
          .join(' ');
      return formattedName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Pokemons'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                if (controller.pokemons == null || controller.pokemons.value == null) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.pokemons.error != null) {
                  return Text('Ocorreu um erro inesperado');
                } else
                  return ListView.builder(
                    itemCount: controller.pokemons.value.results.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 80.0,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                          child: Center(
                            child: ListTile(
                              leading: Image.network(
                                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png'),
                              title: Row(
                                children: [
                                  Text((index + 1).toString(),
                                      style: TextStyle(color: Colors.grey[400])),
                                  SizedBox(width: 8.0),
                                  Text(formatPokemonNames(
                                      controller.pokemons.value.results[index].name)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
