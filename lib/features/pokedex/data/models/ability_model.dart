import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/ability.dart';

class AbilityModel extends Ability {
  const AbilityModel(
      {required super.ability, required super.isHidden, required super.slot});

  factory AbilityModel.fromJson(Map<String, dynamic> json) {
    return AbilityModel(
      ability: SpeciesModel.fromJson(json["ability"]),
      isHidden: json["is_hidden"],
      slot: json["slot"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ability": ability,
      "is_hidden": isHidden,
      "slot": slot,
    };
  }
}
