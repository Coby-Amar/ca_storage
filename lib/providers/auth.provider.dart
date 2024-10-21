import 'package:ca_storage/api.dart';
import 'package:ca_storage/main.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool isLoggedIn = false;

  AuthProvider() {
    verify();
  }

  void verify() async {
    try {
      await ApiService().verify();
      isLoggedIn = true;
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed('/home');
    } catch (e) {
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed('/login');
    }
  }

  void login(String username, String password) async {
    try {
      if (isLoggedIn) return;
      await ApiService().login(username, password);
      isLoggedIn = true;
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed('/home');
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Center(child: Text("Failed to login")),
        ),
      );
    }
  }

  void logout() async {
    try {
      await ApiService().logout();
      isLoggedIn = false;
      Navigator.of(navigatorKey.currentContext!).pushReplacementNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Center(child: Text("Failed to logout")),
        ),
      );
    }
  }
}
