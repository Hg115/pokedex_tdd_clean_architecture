import 'package:flutter/material.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/widget/side_menu.dart';

class FavoritePokemonPage extends StatelessWidget {
  static const String routerName = 'Favorites';
  const FavoritePokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Pokemon'),
      ),
      drawer: const SideMenu(),
    );
  }
}
