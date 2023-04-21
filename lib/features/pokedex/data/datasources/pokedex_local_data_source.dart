import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';

abstract class PokedexLocalDataSource {
  Future<PokemonModel> getPokemonId(int id);
  Future<PokemonModel> getPokemonName(String name);
  Future<List<PokemonModel>> listFavoritePokemon();
  Future<PokemonModel> addFavorite(int id);
  Future<PokemonModel> removeFavorite(int id);
}

class PokedexLocalDataSourceImpl extends PokedexLocalDataSource {
  final int db;

  PokedexLocalDataSourceImpl(this.db);

  @override
  Future<PokemonModel> addFavorite(int id) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<PokemonModel> getPokemonId(int id) {
    // TODO: implement getPokemonId
    throw UnimplementedError();
  }

  @override
  Future<PokemonModel> getPokemonName(String name) {
    // TODO: implement getPokemonName
    throw UnimplementedError();
  }

  @override
  Future<List<PokemonModel>> listFavoritePokemon() {
    // TODO: implement listFavoritePokemon
    throw UnimplementedError();
  }

  @override
  Future<PokemonModel> removeFavorite(int id) {
    // TODO: implement removeFavorite
    throw UnimplementedError();
  }
}
