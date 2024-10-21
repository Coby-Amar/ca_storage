import 'package:ca_storage/api.dart';
import 'package:ca_storage/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  void login() async {
    if (username.isNotEmpty && password.isNotEmpty) {
      context.read<AuthProvider>().login(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(color: colorScheme.onPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => setState(() => username = value),
                decoration: const InputDecoration(
                  label: Text("Username"),
                ),
              ),
              TextFormField(
                onChanged: (value) => setState(() => password = value),
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ElevatedButton(
                  onPressed: login,
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStatePropertyAll(colorScheme.onPrimary),
                    backgroundColor:
                        MaterialStatePropertyAll(colorScheme.primary),
                  ),
                  child: const Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
