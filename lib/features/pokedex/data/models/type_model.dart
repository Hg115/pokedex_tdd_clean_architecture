import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/type.dart';

class TypeModel extends Type {
  const TypeModel({required super.slot, required super.type});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      slot: json["slot"],
      type: SpeciesModel.fromJson(json["type"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "slot": slot,
      "type": type,
    };
  }
}
