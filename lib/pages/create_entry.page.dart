import 'package:ca_storage/providers/categories.provider.dart';
import 'package:ca_storage/providers/entries.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEntryPage extends StatefulWidget {
  const CreateEntryPage({super.key});

  @override
  State<CreateEntryPage> createState() => _CreateEntryPageState();
}

class _CreateEntryPageState extends State<CreateEntryPage> {
  final entry = EntryModel()..seasons = [SeasonModel()];

  createAndClose() {
    context.read<EntriesProvider>().createEntry(entry);
    Navigator.of(context).pop();
  }

  _addSeason() => setState(() => entry.seasons.add(SeasonModel()));

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categories = context.watch<CategoriesProvider>().categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Entry"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.name,
              onChanged: (value) => setState(() => entry.name = value),
            ),
            DropdownButtonFormField(
              hint: const Text("Category"),
              items: categories
                  .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => entry.category = value);
                }
              },
            ),
            ...entry.seasons.map((e) => Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Season'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) =>
                            setState(() => e.season = int.tryParse(value) ?? 0),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Current Episode'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(
                            () => e.currentEp = int.tryParse(value) ?? 0),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Max Episodes'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) =>
                            setState(() => e.maxEp = int.tryParse(value) ?? -1),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createAndClose,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll(colorScheme.onPrimary),
                backgroundColor: MaterialStatePropertyAll(colorScheme.primary),
              ),
              child: const Text('Create'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: entry.seasons.length > 1,
            child: TextButton(
              onPressed: () => setState(() => entry.seasons.removeLast()),
              child: const Text("Remove Season"),
            ),
          ),
          TextButton(
            onPressed: _addSeason,
            child: const Text("Add Season"),
          ),
        ],
      ),
    );
  }
}
