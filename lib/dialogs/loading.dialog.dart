import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return const SimpleDialog(
      title: Center(child: Text("Loading... Please Wait")),
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}

extension LoadingDialogShower on LoadingDialog {
  static void openLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );
  }

  static void closeLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
