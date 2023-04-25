import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_tdd_clean_architecture/core/database/database_pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/datasources/pokedex_local_data_source.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/ability_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/held_item_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/move_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/sprites_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/stats_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/type_model.dart';
import 'package:sqflite/sqflite.dart';

@GenerateNiceMocks([MockSpec<DBPokedex>()])
import 'pokedex_local_data_source_test.mocks.dart';

void main() {
  late PokedexLocalDataSourceImpl dataSource;
  late MockDBPokedex mockDBPokedex;

  setUp(() {
    mockDBPokedex = MockDBPokedex();
    dataSource = PokedexLocalDataSourceImpl(db: mockDBPokedex);
  });

  const tPokemonModel = PokemonModel(
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

  const tListPokemon = [tPokemonModel];

  group('getPokemonName', () {
    test(
      "should get pokemon by name from the database",
      () async {
        //arrange
        when(mockDBPokedex.getPokemonName(any))
            .thenAnswer((_) async => tPokemonModel);
        //act
        final result = await dataSource.getPokemonName(tPokemonModel.name);
        //assert
        expect(result, tPokemonModel);
        verify(mockDBPokedex.getPokemonName(tPokemonModel.name));
      },
    );

    test(
      "should throw a CacheException when an errors happends at the database",
      () async {
        //arrange
        when(mockDBPokedex.getPokemonName(any)).thenThrow(DatabaseException);
        //act
        final call = dataSource.getPokemonName;
        //assert

        expect(() => call(tPokemonModel.name),
            throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('getPokemonId', () {
    test(
      "should get pokemon by id from the database",
      () async {
        //arrange
        when(mockDBPokedex.getPokemonId(any))
            .thenAnswer((_) async => tPokemonModel);
        //act
        final result = await dataSource.getPokemonId(tPokemonModel.id);
        //assert
        expect(result, tPokemonModel);
        verify(mockDBPokedex.getPokemonId(tPokemonModel.id));
      },
    );

    test(
      "should throw a CacheException when an errors happends at the database",
      () async {
        //arrange
        when(mockDBPokedex.getPokemonId(any)).thenThrow(DatabaseException);
        //act
        final call = dataSource.getPokemonId;
        //assert

        expect(() => call(tPokemonModel.id),
            throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('ListFavoritePokemon', () {
    test(
      "should get the Favorite Pokemon by name",
      () async {
        //arrange
        when(mockDBPokedex.getAllPokemon())
            .thenAnswer((_) async => tListPokemon);
        //act
        final result = await dataSource.listFavoritePokemon();
        //assert
        expect(result, tListPokemon);
        verify(mockDBPokedex.getAllPokemon());
      },
    );

    test(
      "should throw a CacheException when an errors happends at the database",
      () async {
        //arrange
        when(mockDBPokedex.getAllPokemon()).thenThrow(DatabaseException);
        //act
        final call = dataSource.listFavoritePokemon;
        //assert

        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });
  group('RemovePokemon', () {
    test(
      "should if pokemon exists ",
      () async {
        //arrange
        when(mockDBPokedex.getPokemonId(any))
            .thenAnswer((_) async => tPokemonModel);
        //act
        dataSource.removeFavorite(tPokemonModel.id);
        //assert

        verify(mockDBPokedex.getPokemonId(tPokemonModel.id));
      },
    );

    test(
      "should throw a CacheException when an errors ocurred when id isn't found",
      () async {
        //arrange
        when(mockDBPokedex.getPokemonId(any)).thenAnswer((_) async => null);
        //act
        final call = dataSource.removeFavorite;
        //assert
        expect(() => call(tPokemonModel.id),
            throwsA(const TypeMatcher<CacheException>()));
        verifyNever(mockDBPokedex.deletePokemon(tPokemonModel.id));
      },
    );
  });
  group('AddPokemon', () {
    test(
      "should add a pokemon to favorite list",
      () async {
        //arrange
        when(mockDBPokedex.newPokemon(any))
            .thenAnswer((_) async => tPokemonModel.id);
        //act
        await dataSource.addFavorite(tPokemonModel);
        //assert
        verify(mockDBPokedex.newPokemon(tPokemonModel));
      },
    );

    test(
      "should throw a CacheException when an errors happends at the database",
      () async {
        //arrange
        when(mockDBPokedex.newPokemon(any)).thenThrow(DatabaseException);
        //act
        final call = dataSource.addFavorite;
        //assert

        expect(() => call(tPokemonModel),
            throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });
}
