import 'package:dartz/dartz.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';

import '../../../../core/error/failures.dart';

abstract class PokedexRepository {
  Future<Either<Failure, Pokemon>> getPokemonId(int id);
  Future<Either<Failure, Pokemon>> getPokemonName(String name);
}
