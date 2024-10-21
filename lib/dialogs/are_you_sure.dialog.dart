import 'package:ca_storage/providers/entries.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SimpleDialog(
      title: const Center(child: Text("Are you sure")),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No"),
            )
          ],
        )
      ],
    );
  }
}
