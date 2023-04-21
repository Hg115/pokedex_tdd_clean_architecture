import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/move.dart';

class MoveModel extends Move {
  const MoveModel({required super.move});

  factory MoveModel.fromJson(Map<String, dynamic> json) {
    return MoveModel(
      move: SpeciesModel.fromJson(json["move"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {'move': move};
  }
}
