import 'package:flutter/material.dart';

class CreateFolder extends StatelessWidget {
  const CreateFolder({super.key});

  @override
  Widget build(BuildContext context) {
    final data = 'data';
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(data),
        ],
      ),
    );
  }
}
