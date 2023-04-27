import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/pokemon_repository.dart';

class GetConcreteName implements UseCase<Pokemon, ParamsName> {
  final PokedexRepository repository;

  GetConcreteName(this.repository);

  @override
  Future<Either<Failure, Pokemon>> call(ParamsName params) async {
    return await repository.getPokemonName(params.name);
  }
}

class ParamsName extends Equatable {
  final String name;

  const ParamsName({required this.name});

  @override
  List<Object> get props => [name];
}
