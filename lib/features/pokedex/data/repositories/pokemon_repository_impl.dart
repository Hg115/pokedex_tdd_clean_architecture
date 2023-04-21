import 'package:dartz/dartz.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokedex_remote_data_source.dart';

typedef _IdOrNameChoosing = Future<PokemonModel> Function();

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource remoteDataSource;
  //final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokedexRepositoryImpl(
      {required this.remoteDataSource,
      //required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Pokemon>> getPokemonId(int id) async {
    return await _getIdOrName(() {
      return remoteDataSource.getPokemonId(id);
    });
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonName(String name) async {
    return await _getIdOrName(() {
      return remoteDataSource.getPokemonName(name);
    });
  }

  Future<Either<Failure, Pokemon>> _getIdOrName(
    _IdOrNameChoosing idOrNameChoosing,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await idOrNameChoosing();
        //localDataSource.cacheNumberTrivia(remoteTrivia);
        remoteDataSource.getPokemonId(remoteData as int);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
