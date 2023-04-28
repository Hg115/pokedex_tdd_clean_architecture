import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';

import '../../domain/entities/stats.dart';

class ShowPokemon extends StatelessWidget {
  final Pokemon pokemon;
  final List<Stat> stats;

  const ShowPokemon({super.key, required this.pokemon, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
            child: Text('Nombre e Id del Pokemon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            height: 50,
            child: _Header(pokemon: pokemon),
          ),
          const SizedBox(
            height: 50,
            child: Text('Sprite del Pokemon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          _PokemonSprites(pokemon: pokemon),
          const SizedBox(
            height: 50,
            child: Text('Stats del Pokemon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          SizedBox(
            width: 200,
            height: 300,
            child: ListView.separated(
              itemBuilder: (context, int index) {
                return _PokemonStats(stats: stats[index]);
              },
              itemCount: stats.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 8),
            ),
          ),
          const SizedBox(
            height: 50,
            child: Text('Tamaño y Peso del Pokemon',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
              child: Text(
                pokemon.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
                height: 20,
                child: Text(
                  '${pokemon.id}',
                  style: const TextStyle(fontSize: 20),
                )),
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
      height: 50,
      width: 50,
      fit: BoxFit.fill,
    );
  }
}

//Stats del Pokemon

class _PokemonStats extends StatelessWidget {
  final Stat stats;

  const _PokemonStats({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 60,
          child: Text(stats.stat.name),
        ),
        SizedBox(
          height: 40,
          width: 20,
          child: Text("${stats.baseStat}",
              style: TextStyle(color: _colorStats(stats.baseStat))),
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
          child: Text('Estatura: ${pokemon.height}',
              style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: Text(
            'Peso: ${pokemon.weight}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
