import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class PokedexRemoteDataSource {
  ///Calls the http://numbersapi.com/{number} endpoint.
  ///
  ///Throw a [ServerException] for all error codes.
  Future<PokemonModel> getPokemonId(int id);

  ///Calls de http://numbersapi.com/random endpoint
  ///
  ///Throws a [ServerException] for all error codes.
  Future<PokemonModel> getPokemonName(String name);
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final http.Client client;

  PokedexRemoteDataSourceImpl({required this.client});

  @override
  Future<PokemonModel> getPokemonId(int id) =>
      _getTriviaFromUrl('https://pokeapi.co/api/v2/pokemon/$id');

  @override
  Future<PokemonModel> getPokemonName(String name) =>
      _getTriviaFromUrl('https://pokeapi.co/api/v2/pokemon/$name');

  Future<PokemonModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
