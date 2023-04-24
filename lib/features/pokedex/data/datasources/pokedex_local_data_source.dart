import 'package:pokedex_tdd_clean_architecture/core/database/database_pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';

abstract class PokedexLocalDataSource {
  Future<PokemonModel> getPokemonId(int id);
  Future<PokemonModel> getPokemonName(String name);
  Future<List<PokemonModel>> listFavoritePokemon();
  Future<PokemonModel> addFavorite(PokemonModel pokemon);
  Future<PokemonModel> removeFavorite(int id);
}

class PokedexLocalDataSourceImpl extends PokedexLocalDataSource {
  final DBPokedex db;

  PokedexLocalDataSourceImpl({required this.db});

  @override
  Future<PokemonModel> addFavorite(PokemonModel pokemon) async {
    try {
      final favorite = pokemon;
      await db.newPokemon(pokemon);
      return favorite;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<PokemonModel> getPokemonId(int id) async {
    try {
      final pokemon = await db.getPokemonId(id);

      if (pokemon == null) throw CacheException();

      return pokemon;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<PokemonModel> getPokemonName(String name) async {
    try {
      final pokemon = await db.getPokemonName(name);

      if (pokemon == null) throw CacheException();

      return pokemon;
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<List<PokemonModel>> listFavoritePokemon() async {
    try {
      return await db.getAllPokemon();
    } catch (error) {
      throw CacheException();
    }
  }

  @override
  Future<PokemonModel> removeFavorite(int id) async {
    try {
      final remove = db.getPokemonId(id);
      await db.deletePokemon(id);
      return remove;
    } catch (error) {
      throw CacheException();
    }
  }
}
