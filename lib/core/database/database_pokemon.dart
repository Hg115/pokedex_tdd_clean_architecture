import 'dart:convert';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/pokedex/data/models/pokemon_model.dart';

class DBPokedex {
  static Database? _database;

  static final DBPokedex db = DBPokedex._();

  DBPokedex._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'pokedex.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE Pokemon(
                id INTEGER PRIMARY KEY NOT NULL,
                name TEXT UNIQUE,
                data TEXT NOT NULL
                )
              ''');
    });
  }

  Future<int> newPokemon(PokemonModel pokemon) async {
    final db = await database;

    return db.insert('Pokemon', {
      'id': pokemon.id,
      'name': pokemon.name,
      'data': json.encode(pokemon.toJson())
    });
  }

  Future<int> deletePokemon(int id) async {
    final db = await database;

    return await db.delete('Pokemon', where: 'id = ?', whereArgs: [id]);
  }

  Future<PokemonModel> getPokemonId(int id) async {
    final db = await database;
    final res = await db.query('Pokemon', where: 'id = ?', whereArgs: [id]);

    if (res.isEmpty) {
      throw Exception('No se encontó pokemon con el id proporcionado');
    }

    return PokemonModel.fromJson(res.first);
  }

  Future<PokemonModel> getPokemonName(String name) async {
    final db = await database;
    final res = await db.query('Pokemon', where: 'name = ?', whereArgs: [name]);

    if (res.isEmpty) {
      throw Exception('No se encontó pokemon con el nombre proporcionado');
    }

    return PokemonModel.fromJson(res.first);
  }

  Future<List<PokemonModel>> getAllPokemon() async {
    final db = await database;
    final res = await db.query('Pokemon', columns: ['data']);

    return res.map((res) => _getSinglePokemon(res)).toList();
  }

  PokemonModel _getSinglePokemon(Map<String, Object?> res) {
    return PokemonModel.fromJson(
      json.decode(
        Map.from(res)['data'],
      ),
    );
  }
}
