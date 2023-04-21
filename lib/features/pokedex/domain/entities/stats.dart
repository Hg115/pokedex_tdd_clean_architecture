import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';

class Stat extends Equatable {
  const Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  final int baseStat;
  final int effort;
  final Species stat;

  @override
  List<Object> get props => [baseStat, effort, stat];
}
