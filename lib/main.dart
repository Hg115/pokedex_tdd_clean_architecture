import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/pages/pages.dart';
import 'features/pokedex/presentation/bloc/pokemon_bloc.dart';
import 'injection_container.dart' as inj;

void main() {
  inj.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inj.sl<PokemonBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        initialRoute: 'homepage',
        routes: {
          'homepage': (_) => const HomePage(),
          'favorite': (_) => const FavoritePokemon(),
        },
        theme: _themeData(),
      ),
    );
  }

  ThemeData _themeData() {
    return ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo, elevation: 0));
  }
}
