import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';

class HeldItem extends Equatable {
  const HeldItem({required this.item});

  final Species item;

  @override
  List<Object> get props => [item];
}
