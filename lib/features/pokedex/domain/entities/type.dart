import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';

class Type extends Equatable {
  const Type({
    required this.slot,
    required this.type,
  });

  final int slot;
  final Species type;

  @override
  List<Object> get props => [slot, type];
}
