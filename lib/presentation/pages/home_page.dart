import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dog_dashboard/presentation/pages/create_dog_page.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _SavedDogsPageState();
}

class _SavedDogsPageState extends State<HomePage> {
  late Box dogsBox;

  @override
  void initState() {
    super.initState();
    Hive.openBox('dogs').then((box) {
      setState(() => dogsBox = box);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box>(
      future: Hive.openBox('dogs'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final dogsBox = snapshot.data!;
        final dogs = dogsBox.values.toList();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('🐾 Dog Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_forever),
                tooltip: 'Clear all dogs',
                onPressed: () {
                  if (dogsBox.isEmpty) return;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Clear all dogs?'),
                      content: const Text(
                          'Are you sure you want to delete all saved dogs?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            dogsBox.clear();
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          body: dogs.isEmpty
              ? const Center(child: Text('No saved dogs yet'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: dogs.length,
                  itemBuilder: (context, index) {
                    final dog = dogs[index] as Map;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(dog['imageUrl']),
                        ),
                        title: Text(
                          dog['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country: ${dog['countryOfOrigin']}'),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                dog['ownerImageUrl'] != null
                                    ? CircleAvatar(
                                        radius: 15,
                                        backgroundImage: FileImage(
                                          File(dog['ownerImageUrl']),
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Owner: ${dog['ownerName']}',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  tooltip: 'Delete dog',
                                  onPressed: () {
                                    dogsBox.deleteAt(index);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateDogPage(),
                ),
              )
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
