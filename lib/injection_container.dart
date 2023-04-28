import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokedex_tdd_clean_architecture/core/database/database_pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/core/network/network_info.dart';
import 'package:pokedex_tdd_clean_architecture/core/util/input_converter.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/datasources/pokedex_local_data_source.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_id.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/domain/usescases/get_pokemon_name.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/bloc/bloc.dart';

import 'features/pokedex/domain/repositories/pokemon_repository.dart';

final GetIt sl = GetIt.instance;

void init() {
  //bloc

  sl.registerFactory(() => PokemonBloc(
        getConcreteId: sl(),
        getConcreteName: sl(),
        inputConverter: sl(),
      ));

  //use cases
  sl.registerLazySingleton(() => GetConcreteId(sl()));
  sl.registerLazySingleton(() => GetConcreteName(sl()));

  //repository
  sl.registerLazySingleton<PokedexRepository>(() => PokedexRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ));

  //Data sources
  sl.registerLazySingleton<PokedexLocalDataSource>(
      () => PokedexLocalDataSourceImpl(db: sl()));

  sl.registerLazySingleton<PokedexRemoteDataSource>(
      () => PokedexRemoteDataSourceImpl(client: sl()));

  //Core
  final db = DBPokedex.db;

  sl.registerLazySingleton(() => db);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
