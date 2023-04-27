import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/ability_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/held_item_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/move_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/species_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/sprites_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/stats_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/type_model.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_name.dart';

import 'get_pokemon_name_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PokedexRepository>()])
void main() {
  late GetConcreteName usecase;
  late MockPokedexRepository mockPokedexRepository;

  setUp(() {
    mockPokedexRepository = MockPokedexRepository();
    usecase = GetConcreteName(mockPokedexRepository);
  });

  const tPokemonName = Pokemon(
      abilities: [
        AbilityModel(
            ability: SpeciesModel(
                name: 'limber', url: 'https://pokeapi.co/api/v2/ability/7/'),
            isHidden: false,
            slot: 1)
      ],
      baseExperience: 101,
      height: 3,
      heldItems: [
        HeldItemModel(
            item: SpeciesModel(
                name: 'metal-powder',
                url: 'https://pokeapi.co/api/v2/item/234/'))
      ],
      id: 132,
      moves: [
        MoveModel(
            move: SpeciesModel(
                name: 'transform', url: 'https://pokeapi.co/api/v2/move/144/'))
      ],
      name: 'ditto',
      order: 214,
      species: SpeciesModel(
          name: 'ditto', url: 'https://pokeapi.co/api/v2/pokemon-species/132/'),
      sprites: SpritesModel(
        backDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png',
        backShiny:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/132.png',
        frontDefault:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png',
        frontShiny:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/132.png',
      ),
      stats: [
        StatsModel(
            baseStat: 48,
            effort: 1,
            stat: SpeciesModel(
                name: 'hp', url: 'https://pokeapi.co/api/v2/stat/1/'))
      ],
      types: [
        TypeModel(
            slot: 1,
            type: SpeciesModel(
                name: 'normal', url: 'https://pokeapi.co/api/v2/type/1/'))
      ],
      weight: 40);
  test(
    'should get the name of the pokemon from the repository',
    () async {
      when(mockPokedexRepository.getPokemonName(any))
          .thenAnswer((_) async => const Right(tPokemonName));

      final result = await usecase(ParamsName(name: tPokemonName.name));

      expect(result, const Right(tPokemonName));
      verify(mockPokedexRepository.getPokemonName(tPokemonName.name));
      verifyNoMoreInteractions(mockPokedexRepository);
    },
  );
}
