import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:novo/app/app_controller.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  AppController appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            return Text(appController.nomeCompleto);
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextField(
              controller: TextEditingController(
                text: appController.nomeCliente,
              ),
              onChanged: (value) => controller.setNomeCliente(value),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextField(
              controller: TextEditingController(
                text: appController.sobrenomeCliente,
              ),
              onChanged: (value) => controller.setSobrenomeCliente(value),
            ),
          ),
          SizedBox(height: 64.0),
          Expanded(
            child: Observer(
              builder: (_) {
                if (controller.pokemons == null ||
                    controller.pokemons.value == null) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.pokemons.error != null) {
                  return Text('Ocorreu um erro inesperado');
                } else
                  return ListView.builder(
                    itemCount: controller.pokemons.value.results.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 32.0),
                        padding: EdgeInsets.all(16.0),
                        child:
                            Text(controller.pokemons.value.results[index].name),
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
