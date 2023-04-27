// Mocks generated by Mockito 5.4.0 from annotations
// in pokedex_tdd_clean_architecture/test/features/presentation/bloc/pokemon_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex_tdd_clean_architecture/core/error/failures.dart' as _i6;
import 'package:pokedex_tdd_clean_architecture/core/util/input_converter.dart'
    as _i9;
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/entities/pokemon.dart'
    as _i7;
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/repositories/pokemon_repository.dart'
    as _i2;
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_id.dart'
    as _i4;
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_name.dart'
    as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePokedexRepository_0 extends _i1.SmartFake
    implements _i2.PokedexRepository {
  _FakePokedexRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetConcreteId].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteId extends _i1.Mock implements _i4.GetConcreteId {
  @override
  _i2.PokedexRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakePokedexRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakePokedexRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.PokedexRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>> call(_i4.ParamsId? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>>.value(
            _FakeEither_1<_i6.Failure, _i7.Pokemon>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>>.value(
                _FakeEither_1<_i6.Failure, _i7.Pokemon>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>>);
}

/// A class which mocks [GetConcreteName].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetConcreteName extends _i1.Mock implements _i8.GetConcreteName {
  @override
  _i2.PokedexRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakePokedexRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakePokedexRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.PokedexRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>> call(
          _i8.ParamsName? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>>.value(
            _FakeEither_1<_i6.Failure, _i7.Pokemon>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>>.value(
                _FakeEither_1<_i6.Failure, _i7.Pokemon>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Pokemon>>);
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i9.InputConverter {
  @override
  _i3.Either<_i6.Failure, String> emptyString(String? str) =>
      (super.noSuchMethod(
        Invocation.method(
          #emptySting,
          [str],
        ),
        returnValue: _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #emptyString,
            [str],
          ),
        ),
        returnValueForMissingStub: _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #emptyString,
            [str],
          ),
        ),
      ) as _i3.Either<_i6.Failure, String>);
}
