import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonId extends PokemonEvent {
  final int id;

  const GetPokemonId(this.id);

  @override
  List<Object> get props => [id];
}

class GetPokemonName extends PokemonEvent {
  final String name;

  const GetPokemonName(this.name);

  @override
  List<Object> get props => [name];
}
