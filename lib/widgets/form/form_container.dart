import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final List<Widget> children;
  const FormContainer({super.key, required this.children});

  @override
  State<FormContainer> createState() => FormContainerState();
}

class FormContainerState extends State<FormContainer> {
  final List<FormField> _fields = [];

  @override
  void initState() {
    for (final element in widget.children) {
      if (element is FormField) {
        _fields.add(element);
      }
    }
    super.initState();
  }

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: widget.children,
      ),
    );
  }
}

class FormField extends StatefulWidget {
  const FormField({super.key});

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
