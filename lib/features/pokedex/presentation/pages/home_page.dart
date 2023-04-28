import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_state.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/widget/search_pokemon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pokedex'),
      ),
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Busca un Pokémon por su nombre o utilizando su número de Pokédex.',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 20),
        const SearchPokemon(),
        const _State(),
        //const Expanded(child: _State()),
      ],
    );
  }
}

class _State extends StatelessWidget {
  const _State();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
      if (state is LoadedPokemon) return const CircularProgressIndicator();

      if (state is Loading) return const Text('Loading');

      if (state is Error) return const Text('Error');

      return const Text('Error Desconocido');
    });
  }
}
