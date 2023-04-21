import 'package:equatable/equatable.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/species.dart';

class Move extends Equatable {
  const Move({
    required this.move,
  });

  final Species move;

  @override
  List<Object> get props => [move];
}
