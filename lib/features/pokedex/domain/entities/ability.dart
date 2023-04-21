import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';

class Ability extends Equatable {
  const Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  final Species ability;
  final bool isHidden;
  final int slot;

  @override
  List<Object> get props => [ability, isHidden, slot];
}
