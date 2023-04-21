import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/ability.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/held_item.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/move.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/sprites.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/stats.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/type.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final List<Ability> abilities;
  final int baseExperience;
  final int height;
  final List<HeldItem> heldItems;
  final List<Move> moves;
  final int order;
  final Species species;
  final Sprites sprites;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  const Pokemon({
    required this.id,
    required this.name,
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.heldItems,
    required this.moves,
    required this.order,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  @override
  List<Object> get props => [
        id,
        name,
        order,
        abilities,
        baseExperience,
        height,
        heldItems,
        moves,
        order,
        species,
        sprites,
        stats,
        types,
        weight
      ];
}
