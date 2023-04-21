import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_tdd_clean_architecture/core/error/exceptions.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/models/pokemon_model.dart';

import '../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'pokedex_remote_data_source_test.mocks.dart';

void main() {
  late PokedexRemoteDataSourceImpl datasource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    datasource = PokedexRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('pokemon.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('GetPokemonName', () {
    final tPokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon.json')));

    test(
      '''should perform get request on a url with parameters being the endpoint and with application/json header''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        datasource.getPokemonName(tPokemonModel.name);
        //assert
        verifyNever(mockHttpClient.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/$tPokemonModel.name'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      "should return Pokemon when the response is 200 (success)",
      () async {
        //arrange
        setUpMockHttpClientSuccess200();

        //act
        final result = await datasource.getPokemonName(tPokemonModel.name);
        //assert
        expect(result, equals(tPokemonModel));
      },
    );

    test(
      "should throw a ServerException when the response is 404 or other",
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = datasource.getPokemonName;
        //assert
        expect(() => call(tPokemonModel.name),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });

  group('getPokemonId', () {
    final tPokemonModel =
        PokemonModel.fromJson(json.decode(fixture('pokemon.json')));

    test(
      '''should perfom a get request on a url with an id being the endpoint and with application/json header''',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        //act
        datasource.getPokemonId(tPokemonModel.id);
        //assert
        verifyNever(mockHttpClient.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon/$tPokemonModel.id'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      "should return Pokemon when the response is 200 (success)",
      () async {
        //arrange
        setUpMockHttpClientSuccess200();

        //act
        final result = await datasource.getPokemonId(tPokemonModel.id);
        //assert
        expect(result, equals(tPokemonModel));
      },
    );

    test(
      "should throw a ServerException when the response is 404 or other",
      () async {
        //arrange
        setUpMockHttpClientFailure404();
        //act
        final call = datasource.getPokemonId;
        //assert
        expect(() => call(tPokemonModel.id),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
