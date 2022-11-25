import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:state_project/src/pages/home/controller/home_controller.dart';
import 'package:state_project/src/services/current_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = GetIt.I.get();

  @override
  void initState() {
    controller.initPokemon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('POKEMONS'),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.currentState,
          builder: (context, state, __) {
            return SizedBox(
              child: state == CurrentStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : state == CurrentStatus.failed
                      ? const Center(
                          child: Text('Deu erro'),
                        )
                      : ListView(
                          children: controller.pokemons
                              .map((e) => ListTile(
                                    title: Text(e.name),
                                    onTap: () =>
                                        controller.onSelectPokemon(e.url),
                                  ))
                              .toList(),
                        ),
            );
          }),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: controller.currentStateSelectPokemon,
          builder: (context, state, _) {
            return SizedBox(
              height: 80,
              child: state == CurrentStatus.empty
                  ? const Center(child: Text('Adicione um Pokemon'))
                  : state == CurrentStatus.loading
                      ? const Center(child: CircularProgressIndicator())
                      : state == CurrentStatus.failed
                          ? const Center(child: Text('Deu erro'))
                          : Row(
                              children: controller.selectedPokemon
                                  .map(
                                    (e) => Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.red)),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height: 80,
                                      child: Image.network(e.image),
                                    ),
                                  )
                                  .toList(),
                            ),
            );
          }),
    );
  }
}
