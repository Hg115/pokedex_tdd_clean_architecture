import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/entities/stats.dart';

class ShowPokemon extends StatelessWidget {
  final Pokemon pokemon;
  final Stat stats;

  const ShowPokemon({super.key, required this.pokemon, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 15,
            child: Text('Nombre e Id del Pokemon'),
          ),
          _Header(pokemon: pokemon),
          const SizedBox(
            height: 15,
            child: Text('Sprite del Pokemon'),
          ),
          _PokemonSprites(pokemon: pokemon),
          const SizedBox(
            height: 15,
            child: Text('Stats del Pokemon'),
          ),
          _PokemonStats(stats: stats.baseStat),
          const SizedBox(
            height: 15,
            child: Text('Tamaño y Peso del Pokemon'),
          ),
          _SizePokemon(pokemon: pokemon),
        ],
      ),
    );
  }
}
//Nombre e Id del Pokemon

class _Header extends StatelessWidget {
  final Pokemon pokemon;

  const _Header({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              pokemon.name,
              style: textTheme.bodyMedium,
            )),
            const SizedBox(height: 8),
            Text('${pokemon.id}'),
          ],
        ),
      ],
    );
  }
}

//Sprite del Pokemon

class _PokemonSprites extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonSprites({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: const AssetImage('assets/loading.gif'),
      image: CachedNetworkImageProvider(pokemon.sprites.frontDefault),
      height: 20,
      width: 20,
      fit: BoxFit.contain,
    );
  }
}

//Stats del Pokemon

class _PokemonStats extends StatelessWidget {
  final int stats;

  const _PokemonStats({required this.stats});

  @override
  Widget build(BuildContext context) {
    final colorstat = _colorStats(stats);
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Text(
            '$stats',
            style: TextStyle(color: colorstat),
          ),
        ),
      ],
    );
  }

  Color _colorStats(int stats) {
    if (stats < 40) return Colors.red;

    if (stats < 65) return Colors.orange;

    if (stats < 100) return Colors.green.shade300;

    if (stats < 150) return Colors.green.shade600;

    return Colors.green.shade900;
  }
}

//Tamaño del Pokemon

class _SizePokemon extends StatelessWidget {
  final Pokemon pokemon;

  const _SizePokemon({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Text(
            'Estatura: ${pokemon.height}',
          ),
        ),
        SizedBox(
          child: Text(
            'Peso: ${pokemon.weight}',
          ),
        ),
      ],
    );
  }
}
