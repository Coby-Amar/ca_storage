import 'package:ca_storage/db/models.db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ca_storage/db/category.db.dart';
import 'package:ca_storage/dialogs/create_folder.dialogs.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with CreateFolderMixin {
  int _selectedIndex = 0;
  final _items = {
    'Recent': const Icon(Icons.recent_actors_outlined),
    'Categories': const Icon(Icons.category_outlined),
  };

  @override
  void initState() {
    context.read<CategoryDataBase>().listCategories();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.select<CategoryDataBase, List<Category>>(
      (value) => value.categories,
    );
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        centerTitle: true,
        title: Text(
          _items.keys.elementAt(_selectedIndex),
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      body: categories.length > 0
          ? GridView.count(
              crossAxisCount: categories.length,
              children: categories
                  .map(
                    (e) => Text(e.name),
                  )
                  .toList(),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openCreateFolderDialog(context);
          // RouteManager.toNamed(context, AvalableRoutes.folder);
        },
        shape: const CircleBorder(),
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: colorScheme.primary,
        selectedItemColor: colorScheme.onBackground,
        unselectedItemColor: colorScheme.onPrimary,
        onTap: _onItemTapped,
        items: _items.keys
            .map(
              (e) => BottomNavigationBarItem(
                label: e,
                icon: _items[e]!,
              ),
            )
            .toList(),
      ),
    );
  }
}
