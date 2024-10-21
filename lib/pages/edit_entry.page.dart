import 'package:ca_storage/providers/entries.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEntryPage extends StatefulWidget {
  const EditEntryPage({super.key});

  @override
  State<EditEntryPage> createState() => EeditEntryPageState();
}

class EeditEntryPageState extends State<EditEntryPage> {
  final List<SeasonModel> seasons = [];
  createAndClose() {
    context.read<EntriesProvider>().editEntry(entry..seasons.addAll(seasons));
    Navigator.of(context).pop();
  }

  _addSeason() => setState(() => seasons.add(SeasonModel()));

  EntryModel get entry =>
      ModalRoute.of(context)?.settings.arguments as EntryModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update ${entry.name}"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ...entry.seasons.map(
              (e) => Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          e.season.isNegative ? '' : e.season.toString(),
                      decoration: const InputDecoration(labelText: 'Season'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => e.season = int.tryParse(value) ?? 0),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          e.currentEp.isNegative ? '' : e.currentEp.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Current Episode'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(
                          () => e.currentEp = int.tryParse(value) ?? 0),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          e.maxEp.isNegative ? '' : e.maxEp.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Max Episodes'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => e.maxEp = int.tryParse(value) ?? -1),
                    ),
                  ),
                ],
              ),
            ),
            ...seasons.map(
              (e) => Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          e.season.isNegative ? '' : e.season.toString(),
                      decoration: const InputDecoration(labelText: 'Season'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => e.season = int.tryParse(value) ?? 0),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          e.currentEp.isNegative ? '' : e.currentEp.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Current Episode'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(
                          () => e.currentEp = int.tryParse(value) ?? 0),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          e.maxEp.isNegative ? '' : e.maxEp.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Max Episodes'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          setState(() => e.maxEp = int.tryParse(value) ?? -1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createAndClose,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll(colorScheme.onPrimary),
                backgroundColor: MaterialStatePropertyAll(colorScheme.primary),
              ),
              child: const Text('Update'),
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
            visible: seasons.isNotEmpty,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  colorScheme.secondary,
                ),
                foregroundColor: MaterialStatePropertyAll(
                  colorScheme.onSecondary,
                ),
              ),
              onPressed: () => setState(() => seasons.removeLast()),
              child: const Text("Remove Season"),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addSeason,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                colorScheme.secondary,
              ),
              foregroundColor: MaterialStatePropertyAll(
                colorScheme.onSecondary,
              ),
            ),
            child: const Text("Add Season"),
          ),
        ],
      ),
    );
  }
}
