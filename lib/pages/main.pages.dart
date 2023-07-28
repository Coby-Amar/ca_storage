import 'package:ca_storage/pages/create_folder.page.dart';
import 'package:ca_storage/pages/home.page.dart';
import 'package:flutter/material.dart';

enum AvalableRoutes {
  home,
  folder,
  file,
  createFolder,
  createFile,
}

extension Additions on AvalableRoutes {
  toPath() => '/${toString().split('.').last}';
}

class RouteManager {
  static final initialRoute = AvalableRoutes.home.toPath();
  static Map<String, WidgetBuilder> routes = {
    AvalableRoutes.home.toPath(): (context) => const Home(),
    AvalableRoutes.folder.toPath(): (context) => const CreateFolder(),
    AvalableRoutes.file.toPath(): (context) => const CreateFolder(),
    AvalableRoutes.createFolder.toPath(): (context) => const CreateFolder(),
    AvalableRoutes.createFile.toPath(): (context) => const CreateFolder(),
  };

  static toNamed(BuildContext context, AvalableRoutes route) =>
      Navigator.pushNamed(context, route.toPath());
}
