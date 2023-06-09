import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/pokemon_repository.dart';

class GetConcreteId implements UseCase<Pokemon, ParamsId> {
  final PokedexRepository repository;

  GetConcreteId(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(ParamsId params) async {
    return await repository.getPokemonId(params.id);
  }
}

class ParamsId extends Equatable {
  final int id;

  const ParamsId({required this.id});

  @override
  List<Object> get props => [id];
}
