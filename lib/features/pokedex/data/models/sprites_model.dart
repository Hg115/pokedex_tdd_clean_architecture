import '../../domain/entities/sprites.dart';

class SpritesModel extends Sprites {
  const SpritesModel({
    required super.backDefault,
    required super.backShiny,
    required super.frontDefault,
    required super.frontShiny,
  });

  factory SpritesModel.fromJson(Map<String, dynamic> json) {
    return SpritesModel(
      backDefault: json["back_default"],
      backShiny: json["back_shiny"],
      frontDefault: json["front_default"],
      frontShiny: json["front_shiny"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "back_default": backDefault,
      "back_shiny": backShiny,
      "front_default": frontDefault,
      "front_shiny": frontShiny,
    };
  }
}
