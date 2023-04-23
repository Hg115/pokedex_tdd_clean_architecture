import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokedex_tdd_clean_architecture/core/database/database_pokemon.dart';
import 'package:pokedex_tdd_clean_architecture/core/network/network_info.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/datasources/pokedex_local_data_source.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/data/repositories/pokemon_repository_impl.dart';

import 'features/pokedex/domain/repositories/pokemon_repository.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<PokedexRepository>(() => PokedexRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ));

  sl.registerLazySingleton<PokedexLocalDataSource>(
      () => PokedexLocalDataSourceImpl(db: sl()));

  sl.registerLazySingleton<PokedexRemoteDataSource>(
      () => PokedexRemoteDataSourceImpl(client: sl()));

  final db = DBPokedex.db;

  sl.registerLazySingleton(() => db);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
