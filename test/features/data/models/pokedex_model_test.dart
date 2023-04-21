import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/ability_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/held_item_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/move_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/sprites_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/stats_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/type_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  //Held_Item
  const tHeldItem = [
    HeldItemModel(
        item: SpeciesModel(
            name: 'metal-powder', url: 'https://pokeapi.co/api/v2/item/234/')),
    HeldItemModel(
        item: SpeciesModel(
            name: 'quick-powder', url: 'https://pokeapi.co/api/v2/item/251/')),
  ];
  //Ability
  const tAbilities = [
    AbilityModel(
        ability: SpeciesModel(
            name: 'limber', url: 'https://pokeapi.co/api/v2/ability/7/'),
        // ability: [const SpeciesModel(name: 'limber', url: "https://pokeapi.co/api/v2/ability/7/")],
        isHidden: false,
        slot: 1),
    AbilityModel(
        ability: SpeciesModel(
            name: 'imposter', url: 'https://pokeapi.co/api/v2/ability/150/'),
        isHidden: true,
        slot: 3),
  ];
  //Moves
  const tMoves = [
    MoveModel(
        move: SpeciesModel(
            name: 'transform', url: 'https://pokeapi.co/api/v2/move/144/')),
  ];
  //Species
  const tSpecies = SpeciesModel(
      name: 'ditto', url: 'https://pokeapi.co/api/v2/pokemon-species/132/');
  //Sprites
  const tSprites = SpritesModel(
    backDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png',
    backShiny:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png',
    frontDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png',
    frontShiny:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png',
  );

  //Stats
  const tStats = [
    StatsModel(
        baseStat: 48,
        effort: 1,
        stat:
            SpeciesModel(name: 'hp', url: 'https://pokeapi.co/api/v2/stat/1/')),
    StatsModel(
        baseStat: 48,
        effort: 0,
        stat: SpeciesModel(
            name: 'attack', url: 'https://pokeapi.co/api/v2/stat/2/')),
    StatsModel(
        baseStat: 48,
        effort: 0,
        stat: SpeciesModel(
            name: 'defense', url: 'https://pokeapi.co/api/v2/stat/3/')),
    StatsModel(
        baseStat: 48,
        effort: 0,
        stat: SpeciesModel(
            name: 'special-attack', url: 'https://pokeapi.co/api/v2/stat/4/')),
    StatsModel(
        baseStat: 48,
        effort: 0,
        stat: SpeciesModel(
            name: 'special-defense', url: 'https://pokeapi.co/api/v2/stat/5/')),
    StatsModel(
        baseStat: 48,
        effort: 0,
        stat: SpeciesModel(
            name: 'speed', url: 'https://pokeapi.co/api/v2/stat/6/')),
  ];

  //Types
  const tType = [
    TypeModel(
        slot: 1,
        type: SpeciesModel(
            name: 'normal', url: 'https://pokeapi.co/api/v2/type/1/')),
  ];
  //Pokemon
  const tPokemonModel = PokemonModel(
    id: 132,
    name: 'ditto',
    abilities: tAbilities,
    baseExperience: 101,
    height: 3,
    heldItems: tHeldItem,
    moves: tMoves,
    order: 214,
    species: tSpecies,
    sprites: tSprites,
    stats: tStats,
    types: tType,
    weight: 40,
  );

  test('should be a subclass of Pokemon Entity', () async {
    expect(tPokemonModel, isA<PokemonModel>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('pokemon.json'));
      //act
      final result = PokemonModel.fromJson(jsonMap);

      //assert
      expect(result, tPokemonModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      //act
      final result = tPokemonModel.toJson();
      //assert
      final expectedMap = {
        'id': 132,
        'name': 'ditto',
        'abilities': tAbilities,
        'base_experience': 101,
        'height': 3,
        'held_items': tHeldItem,
        'moves': tMoves,
        'order': 214,
        'species': tSpecies,
        'sprites': tSprites,
        'stats': tStats,
        'type': tType,
        'weight': 40,
      };
      expect(result, expectedMap);
    });
  });
}
