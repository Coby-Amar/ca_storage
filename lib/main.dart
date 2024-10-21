import 'package:ca_storage/pages/create_entry.page.dart';
import 'package:ca_storage/pages/edit_entry.page.dart';
import 'package:ca_storage/pages/home.page.dart';
import 'package:ca_storage/pages/splash.page.dart';
import 'package:ca_storage/pages/login.page.dart';
import 'package:ca_storage/providers/auth.provider.dart';
import 'package:ca_storage/providers/categories.provider.dart';
import 'package:ca_storage/providers/entries.provider.dart';
import 'package:ca_storage/providers/tags.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => TagsProvider()),
        ChangeNotifierProvider(create: (_) => EntriesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'CAS',
        initialRoute: '/splash',
        routes: {
          "/splash": (context) => const Splash(),
          "/login": (context) => const LoginPage(),
          "/home": (context) => const Home(),
          "/create_entry": (context) => const CreateEntryPage(),
          "/edit_entry": (context) => const EditEntryPage(),
        },
        // routes: RouteManager.routes,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
      );
}
