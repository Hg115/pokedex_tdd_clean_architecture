import 'package:dartz/dartz.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokedex_local_data_source.dart';
import '../datasources/pokedex_remote_data_source.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource remoteDataSource;
  final PokedexLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokedexRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Pokemon>> addFavorite(Pokemon pokemon) async {
    final pokemonModel = PokemonModel(
      abilities: pokemon.abilities,
      heldItems: pokemon.heldItems,
      baseExperience: pokemon.baseExperience,
      height: pokemon.height,
      id: pokemon.id,
      moves: pokemon.moves,
      name: pokemon.name,
      order: pokemon.order,
      species: pokemon.species,
      sprites: pokemon.sprites,
      stats: pokemon.stats,
      types: pokemon.types,
      weight: pokemon.weight,
    );

    try {
      return Right(await localDataSource.addFavorite(pokemonModel));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonId(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remotedata = await remoteDataSource.getPokemonId(id);
        return Right(remotedata);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localdata = await localDataSource.getPokemonId(id);
        return Right(localdata);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonName(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remotedata = await remoteDataSource.getPokemonName(name);
        return Right(remotedata);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localdata = await localDataSource.getPokemonName(name);
        return Right(localdata);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Pokemon>> removeFavorite(int id) async {
    try {
      return Right(await localDataSource.removeFavorite(id));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
