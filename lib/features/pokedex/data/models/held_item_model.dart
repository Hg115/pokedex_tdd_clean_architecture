import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/held_item.dart';

import '../../domain/entities/species.dart';
import 'species_model.dart';

class HeldItemModel extends HeldItem {
  const HeldItemModel({required Species item}) : super(item: item);

  factory HeldItemModel.fromJson(Map<String, dynamic> json) {
    return HeldItemModel(
      item: SpeciesModel.fromJson(json["item"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
    };
  }
}
