import 'package:flutter/material.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/pages/favorites_pokemon_page.dart';
import 'package:pokedex_tdd_clean_architecture/features/pokedex/presentation/pages/home_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, HomePage.routerName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_rounded),
            title: const Text('Favorite Pokemon'),
            onTap: () {
              //Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, FavoritePokemonPage.routerName);
            },
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
      child: Container(),
    );
  }
}
