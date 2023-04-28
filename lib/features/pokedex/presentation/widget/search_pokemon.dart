import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_event.dart';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPokemon();
}

class _SearchPokemon extends State<StatefulWidget> {
  final controller = TextEditingController();
  String namepokemon = ' ';

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => namepokemon = value,
      onSubmitted: (_) {
        controller.clear();
        BlocProvider.of<PokemonBloc>(context, listen: false)
            .add(GetPokemonName(namepokemon));
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: 'what Pokemon are you looking for?',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}
