import 'package:ca_storage/db/main.db.dart';
import 'package:ca_storage/pages/home.page.dart';
import 'package:ca_storage/pages/main.pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getDatabasesPath();
  final db = await openDatabase(
    join(path, 'ca_local_database.db'),
    version: 1,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryDataBase(db)),
        ChangeNotifierProvider(create: (_) => SubCategoryDataBase(db)),
        ChangeNotifierProvider(create: (_) => ItemDataBase(db)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'CAS',
        initialRoute: RouteManager.initialRoute,
        routes: RouteManager.routes,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
      );
}
