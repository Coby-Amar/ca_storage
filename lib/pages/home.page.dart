import 'package:ca_storage/dialogs/are_you_sure.dialog.dart';
import 'package:ca_storage/dialogs/loading.dialog.dart';
import 'package:ca_storage/providers/auth.provider.dart';
import 'package:ca_storage/providers/entries.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authProvider = context.read<AuthProvider>();
    final entriesProvider = context.watch<EntriesProvider>();
    final entries = entriesProvider.entries;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        centerTitle: true,
        title: const Text("Storage"),
        actions: [
          IconButton(
            onPressed: () async {
              final response = await showDialog(
                context: context,
                builder: (context) => const AreYouSureDialog(),
              );
              if (response ?? false) {
                authProvider.logout();
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: entries.length,
        separatorBuilder: (context, index) => Divider(
          color: colorScheme.onSecondary,
          height: 5,
        ),
        itemBuilder: (context, index) {
          final entry = entries.elementAt(index);
          return ListTile(
            tileColor: colorScheme.secondary,
            onTap: () => Navigator.of(context)
                .pushNamed('/edit_entry', arguments: entry),
            leading: Text(
              entry.status.toDisplay(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: entry.status.toColor(),
              ),
            ),
            title: Text(
              entry.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: colorScheme.onSecondary,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Latest season: ${entry.latestSeason}",
                  style: TextStyle(
                    color: colorScheme.onSecondary,
                  ),
                ),
                Text(
                  "Latest episode: ${entry.latestEpisode}",
                  style: TextStyle(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              color: colorScheme.primary,
              iconColor: colorScheme.onSecondary,
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () => entriesProvider.pauseEntry(entry),
                  child: ListTile(
                    leading: const Icon(Icons.pause),
                    title: Text(STATUS.onHold.toDisplay()),
                    iconColor: STATUS.onHold.toColor(),
                    textColor: STATUS.onHold.toColor(),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  onTap: () => entriesProvider.dropEntry(entry),
                  child: ListTile(
                    leading: const Icon(Icons.stop),
                    title: Text(STATUS.dropped.toDisplay()),
                    iconColor: STATUS.dropped.toColor(),
                    textColor: STATUS.dropped.toColor(),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  onTap: () => entriesProvider.planningEntry(entry),
                  child: ListTile(
                    leading: const Icon(Icons.folder),
                    title: Text(STATUS.planned.toDisplay()),
                    iconColor: STATUS.planned.toColor(),
                    textColor: STATUS.planned.toColor(),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  onTap: () async {
                    final response = await showDialog(
                      context: context,
                      builder: (context) => const AreYouSureDialog(),
                    );
                    if (response ?? false) {
                      entriesProvider.deleteEntry(entry);
                    }
                  },
                  child: const ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                    iconColor: Color(0xFF58181F),
                    textColor: Color(0xFF58181F),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/create_entry'),
        backgroundColor: colorScheme.primary,
        child: Icon(
          Icons.add,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
