import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_tdd_clean_architecture/core/error/failures.dart';
import 'package:pokedex_tdd_clean_architecture/core/util/input_converter.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/ability_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/held_item_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/move_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/sprites_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/stats_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/type_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_id.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_name.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_event.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/pokemon_state.dart';

import 'pokemon_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetPokemonId>(),
  MockSpec<GetPokemonName>(),
  MockSpec<InputConverter>()
])
void main() {
  late PokemonBloc bloc;
  late MockGetConcreteId mockGetConcreteId;
  late MockGetConcreteName mockGetConcreteName;
  late MockInputConverter mockInputConverter;
  setUp(() {
    mockGetConcreteId = MockGetConcreteId();
    mockGetConcreteName = MockGetConcreteName();
    mockInputConverter = MockInputConverter();

    bloc = PokemonBloc(
        getConcreteId: mockGetConcreteId,
        getConcreteName: mockGetConcreteName,
        inputConverter: mockInputConverter);
  });
  const tPokeId = 132;
  const tPokeName = "ditto";
  const tPokedexId = PokemonModel(
      abilities: [
        AbilityModel(
            ability: SpeciesModel(
                name: 'limber', url: 'https://pokeapi.co/api/v2/ability/7/'),
            isHidden: false,
            slot: 1)
      ],
      baseExperience: 101,
      height: 3,
      heldItems: [
        HeldItemModel(
            item: SpeciesModel(
                name: 'metal-powder',
                url: 'https://pokeapi.co/api/v2/item/234/'))
      ],
      id: 132,
      moves: [
        MoveModel(
            move: SpeciesModel(
                name: 'transform', url: 'https://pokeapi.co/api/v2/move/144/'))
      ],
      name: 'ditto',
      order: 214,
      species: SpeciesModel(
          name: 'ditto', url: 'https://pokeapi.co/api/v2/pokemon-species/132/'),
      sprites: SpritesModel(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png',
        backShiny:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png',
        frontShiny:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png',
      ),
      stats: [
        StatsModel(
            baseStat: 48,
            effort: 1,
            stat: SpeciesModel(
                name: 'hp', url: 'https://pokeapi.co/api/v2/stat/1/'))
      ],
      types: [
        TypeModel(
            slot: 1,
            type: SpeciesModel(
                name: 'normal', url: 'https://pokeapi.co/api/v2/type/1/'))
      ],
      weight: 40);
  test('initialState should be Empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetConcretePokemonId', () {
    test(
      "should get data from the concrete id pokemon ",
      () async {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tPokedexId.id));

        when(mockGetConcreteId(any))
            .thenAnswer((_) async => const Right(tPokedexId));
        //act
        bloc.add(GetPokemonId(tPokedexId.id));
        await untilCalled(mockGetConcreteId(any));

        //assert
        verify(mockGetConcreteId(ParamsId(id: tPokedexId.id)));
      },
    );

    test(
      "should emit [Loading, Loaded], when data is gotten succesfully",
      () async {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tPokedexId.id));

        when(mockGetConcreteId(any))
            .thenAnswer((_) async => const Right(tPokedexId));
        //assert Later
        final expected = [
          Loading(),
          const LoadedPokemon(pokemon: tPokedexId),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));
        //act
        bloc.add(GetPokemonId(tPokedexId.id));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tPokedexId.id));

        when(mockGetConcreteId(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final expected = [
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE)
        ];

        expectLater(bloc.stream, emitsInOrder(expected));
        //act
        bloc.add(const GetPokemonId(tPokeId));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tPokedexId.id));

        when(mockGetConcreteId(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        //assert later
        final expected = [
          Loading(),
          const Error(message: CACHE_FAILURE_MESSAGE)
        ];

        expectLater(bloc.stream, emitsInOrder(expected));
        //act
        bloc.add(GetPokemonId(tPokedexId.id));
      },
    );
  });

  group('GetConcretePokemonName', () {
    test(
      "should get data from the concrete name pokemon ",
      () async {
        //arrange

        when(mockGetConcreteName(any))
            .thenAnswer((_) async => const Right(tPokedexId));
        //act
        bloc.add(const GetPokemonName(tPokeName));
        await untilCalled(mockGetConcreteName(any));

        //assert
        verify(mockGetConcreteName(ParamsName(name: tPokedexId.name)));
      },
    );

    test(
      "should emit [Loading, Loaded], when data is gotten succesfully",
      () async {
        //arrange
        when(mockGetConcreteName(any))
            .thenAnswer((_) async => const Right(tPokedexId));
        //assert Later
        final expected = [Loading(), const LoadedPokemon(pokemon: tPokedexId)];

        expectLater(bloc.stream, emitsInOrder(expected));
        //act
        bloc.add(const GetPokemonName(tPokeName));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        const String input = "ditto";

        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tPokedexId.id));

        when(mockGetConcreteName(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        final expected = [
          Loading(),
          const Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        bloc.add(const GetPokemonName(input));

        // //arrange
        // when(mockGetConcreteName(any))
        //     .thenAnswer((_) async => Left(ServerFailure()));
        // //assert later
        // final expected = [
        //   Loading(),
        //   const Error(message: SERVER_FAILURE_MESSAGE)
        // ];

        // expectLater(bloc.stream, emitsInOrder(expected));
        // //act
        // bloc.add(const GetPokemonName(tPokeName));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        //arrange
        const String input = "ditto";

        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tPokedexId.id));

        when(mockGetConcreteName(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        //assert later
        final expected = [
          Loading(),
          const Error(message: CACHE_FAILURE_MESSAGE)
        ];

        expectLater(bloc.stream, emitsInOrder(expected));
        //act
        bloc.add(const GetPokemonName(input));
      },
    );
  });
}
