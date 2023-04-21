import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';

class SpeciesModel extends Species {
  const SpeciesModel({required super.name, required super.url});

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      name: json["name"],
      url: json["url"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
