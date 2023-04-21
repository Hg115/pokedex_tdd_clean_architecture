import 'package:equatable/equatable.dart';

class Sprites extends Equatable {
  const Sprites({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
  });

  final String backDefault;
  final String backShiny;
  final String frontDefault;
  final String frontShiny;

  @override
  List<Object> get props => [
        backDefault,
        backShiny,
        frontDefault,
        frontShiny,
      ];
}
