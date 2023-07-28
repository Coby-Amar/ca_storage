import 'package:ca_storage/db/category.db.dart';
import 'package:ca_storage/db/models.db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFolder extends StatefulWidget {
  const CreateFolder({super.key});

  @override
  State<CreateFolder> createState() => _CreateFolderState();
}

class _CreateFolderState extends State<CreateFolder> {
  String name = '';

  _onSubmit() {
    final provider = context.read<CategoryDataBase>();
    final category = Category.empty(name: name);
    provider.insert(category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Create Category', textAlign: TextAlign.center),
      contentPadding: const EdgeInsets.all(20),
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          onChanged: (value) => setState(() => name = value),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: _onSubmit,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

mixin CreateFolderMixin {
  openCreateFolderDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => const CreateFolder(),
    );
  }
}
