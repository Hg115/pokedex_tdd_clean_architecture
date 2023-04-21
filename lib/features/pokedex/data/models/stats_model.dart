import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';

import '../../domain/entities/stats.dart';

class StatsModel extends Stat {
  const StatsModel(
      {required super.baseStat, required super.effort, required super.stat});

  factory StatsModel.fromJson(Map<String, dynamic> json) {
    return StatsModel(
      baseStat: json["base_stat"],
      effort: json["effort"],
      stat: SpeciesModel.fromJson(json["stat"]),
    );
  }
  Map<String, dynamic> toJson() {
    return {"base_stat": baseStat, "effort": effort, "stat": stat};
  }
}
