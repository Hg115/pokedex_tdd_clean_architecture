import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/ability_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/held_item_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/move_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/sprites_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/stats_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/type_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';

import '../../domain/entities/ability.dart';
import '../../domain/entities/held_item.dart';
import '../../domain/entities/move.dart';

import '../../domain/entities/stats.dart';
import '../../domain/entities/type.dart';

class PokemonModel extends Pokemon {
  const PokemonModel(
      {required super.id,
      required super.name,
      required super.abilities,
      required super.baseExperience,
      required super.height,
      required super.heldItems,
      required super.moves,
      required super.order,
      required super.species,
      required super.sprites,
      required super.stats,
      required super.types,
      required super.weight});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      abilities: List<Ability>.from(
          json["abilities"].map((x) => AbilityModel.fromJson(x))),
      baseExperience: json["base_experience"],
      height: json["height"],
      heldItems: List<HeldItem>.from(
          json["held_items"].map((x) => HeldItemModel.fromJson(x))),
      id: json["id"],
      moves: List<Move>.from(json["moves"].map((x) => MoveModel.fromJson(x))),
      name: json["name"],
      order: json["order"],
      species: SpeciesModel.fromJson(json["species"]),
      sprites: SpritesModel.fromJson(json["sprites"]),
      stats: List<Stat>.from(json["stats"].map((x) => StatsModel.fromJson(x))),
      types: List<Type>.from(json["types"].map((x) => TypeModel.fromJson(x))),
      weight: json["weight"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abilities': abilities,
      'base_experience': baseExperience,
      'height': height,
      'held_items': heldItems,
      'id': id,
      'moves': moves,
      'name': name,
      'order': order,
      'species': species,
      'sprites': sprites,
      'stats': stats,
      'type': types,
      'weight': weight
    };
  }

  PokemonModel copy() => PokemonModel(
        abilities: abilities,
        baseExperience: baseExperience,
        height: height,
        heldItems: heldItems,
        id: id,
        moves: moves,
        name: name,
        order: order,
        species: species,
        sprites: sprites,
        stats: stats,
        types: types,
        weight: weight,
      );
}
