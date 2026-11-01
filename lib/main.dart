import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add.dart';
import 'relaton.dart';
import 'storage.dart';

const Color green = Color.fromARGB(255, 5, 194, 153);

void main() => runApp(const RelatonApp());

class RelatonApp extends StatelessWidget {
  const RelatonApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      title: 'Relaton',
      theme: base.copyWith(
        colorScheme: base.colorScheme.copyWith(primary: green, secondary: green),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: 'monospace', color: green, fontSize: 20),
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: green, foregroundColor: Colors.black),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = RelatonStore();
  List<Relaton> _relatons = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final relatons = await _store.load();
    relatons.sort((a, b) {
      final da = a.daysUntilBirthday, db = b.daysUntilBirthday;
      if (da == null && db == null) return a.name.compareTo(b.name);
      if (da == null) return 1;
      if (db == null) return -1;
      return da.compareTo(db);
    });
    if (mounted) {
      setState(() {
        _relatons = relatons;
        _loading = false;
      });
    }
  }

  Future<void> _addRelaton() async {
    final created = await Navigator.push<Relaton>(
      context,
      MaterialPageRoute(builder: (_) => const AddRelatonPage()),
    );
    if (created != null) {
      await _store.save([..._relatons, created]);
      await _load();
    }
  }

  Future<void> _delete(Relaton relaton) async {
    final remaining = List<Relaton>.from(_relatons)..remove(relaton);
    await _store.save(remaining);
    await _load();
  }

  String _subtitle(Relaton r) {
    final parts = <String>[];
    if (r.phone.isNotEmpty) parts.add(r.phone);
    final days = r.daysUntilBirthday;
    if (r.birthday != null) {
      final date = DateFormat.MMMMd().format(r.birthday!);
      parts.add(days == 0 ? '🎂 Birthday today!' : 'Birthday $date (in $days days)');
    }
    return parts.join('  ·  ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Relaton')),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: green))
          : _relatons.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  itemCount: _relatons.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final r = _relatons[i];
                    return Dismissible(
                      key: ValueKey('${r.name}-${r.phone}-$i'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red.shade900,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 24),
                        child: const Icon(Icons.delete),
                      ),
                      onDismissed: (_) => _delete(r),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: green,
                          child: Text(
                            r.name.isNotEmpty ? r.name[0].toUpperCase() : '?',
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(r.name, style: const TextStyle(fontFamily: 'monospace')),
                        subtitle: _subtitle(r).isEmpty ? null : Text(_subtitle(r)),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRelaton,
        tooltip: 'Add Relaton',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 72, color: green),
            SizedBox(height: 16),
            Text('No relatons yet', style: TextStyle(fontFamily: 'monospace', fontSize: 18)),
            SizedBox(height: 8),
            Text('Tap + to add the people you want to keep in touch with.',
                textAlign: TextAlign.center, style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
