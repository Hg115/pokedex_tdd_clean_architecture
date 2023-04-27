// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex_tdd_clean_architecture/core/util/input_converter.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_name.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_event.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_state.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usescases/get_pokemon_id.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final GetConcreteId getConcreteId;
  final GetConcreteName getConcreteName;
  final InputConverter inputConverter;

  PokemonBloc(
      {required this.getConcreteId,
      required this.getConcreteName,
      required this.inputConverter})
      : super(Empty()) {
    on<GetPokemonId>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.id.toString());
      //final inputEither = await getConcreteId(ParamsId(id: event.id));

      await inputEither.fold(
          (failure) async =>
              emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
          (integer) async {
        emit(Loading());
        final failureOrPokemon = await getConcreteId(ParamsId(id: integer));
        _eitherLoadedOrErrorState(emit, failureOrPokemon);
      });
    });

    on<GetPokemonName>((event, emit) async {
      //final inputEither = await getConcreteName(ParamsName(name: event.name));
      final inputEither = inputConverter.stringToUnsignedInteger(event.name);
      await inputEither.fold(
          (failure) async =>
              emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
          (pokemon) async {
        emit(Loading());
        final failureOrPokemon =
            await getConcreteName(ParamsName(name: event.name));
        _eitherLoadedOrErrorState(emit, failureOrPokemon);
      });
    });
  }

  void _eitherLoadedOrErrorState(
      Emitter<PokemonState> emit, Either<Failure, Pokemon> failureOrPokemon) {
    return emit(failureOrPokemon.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (pokemon) => LoadedPokemon(pokemon: pokemon)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
