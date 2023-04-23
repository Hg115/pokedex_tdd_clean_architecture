import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/ability_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/held_item_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/move_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/sprites_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/stats_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/type_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// void sqfliteTestInit() {
//   // Initialize ffi implementation.
//   sqfliteFfiInit();

//   // Set global factory.
//   databaseFactory = databaseFactoryFfi;
// }

Future main() async {
  sqfliteFfiInit();
  //
  late Database db;
  databaseFactory = databaseFactoryFfi;

  setUp(() async {
    db = await openDatabase(inMemoryDatabasePath, singleInstance: true);
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

  group('Pokemon', () {
    test(
      "should create a table for Pokemon",
      () async {
        //act
        await db.execute('''
                CREATE TABLE Pokemon(
                id INTEGER PRIMARY KEY NOT NULL,
                name TEXT UNIQUE,
                data TEXT NOT NULL
                )
              ''');
        //arrange
        final res = await db.query(
          'sqlite_master',
          where: 'name = ?',
          whereArgs: ['Pokemon'],
        );
        //assert

        expect(res.length, equals(1));
      },
    );

    test(
      "should insert a pokemon on the table",
      () async {
        //act
        await db.insert(
          'Pokemon',
          {
            'id': tPokemonModel.id,
            'name': tPokemonModel.name,
            'data': json.encode(tPokemonModel.toJson())
          },
        );
        //arrange
        //final resp = await db.query('Pokemon');
        //assert
      },
    );
  });
}
