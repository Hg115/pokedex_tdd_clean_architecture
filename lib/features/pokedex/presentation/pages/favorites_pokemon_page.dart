import 'package:flutter/material.dart';

class FavoritePokemon extends StatelessWidget {
  const FavoritePokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Pokemon'),
      ),
    );
  }
}
