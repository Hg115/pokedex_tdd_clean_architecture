import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_state.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/widget/search_pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/widget/show_pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/widget/side_menu.dart';

import '../../../../core/database/database_pokemon.dart';
import '../../data/models/pokemon_model.dart';

class HomePage extends StatelessWidget {
  static const String routerName = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pokedex'),
      ),
      drawer: const SideMenu(),
      body: Stack(
        children: const [
          _Header(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            'Busca un Pokémon por su nombre o utilizando su número de Pokédex.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          SearchPokemon(),
          _State(),
        ],
      ),
    );
  }
}

class _AddFavoriteState extends StatelessWidget {
  final PokemonModel pokemon;
  late DBPokedex db;

  _AddFavoriteState(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.favorite,
          size: 10,
          weight: 10,
        ),
        onPressed: () {
          db.newPokemon(pokemon);
        },
      ),
    );
  }
}

class _State extends StatelessWidget {
  const _State();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
      if (state is LoadedPokemon) {
        return ShowPokemon(pokemon: state.pokemon, stats: state.pokemon.stats);
      }

      if (state is Loading) {
        return const Center(child: CircularProgressIndicator.adaptive());
      }

      if (state is Error) return _DisplayMensaje(mensaje: state.message);

      return const Text('Error Desconocido');
    });
  }
}

class _DisplayMensaje extends StatelessWidget {
  final String mensaje;

  const _DisplayMensaje({required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(mensaje),
    );
  }
}
