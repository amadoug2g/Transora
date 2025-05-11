import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<String> items = ["Item 1", "Item 2", "Item 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Transora"),
      ),
      body: ListView(
        children: items
            .map(
              (item) => Card(
                elevation: 2,
                child: ListTile(
                  title: Text(item),
                  onTap: () {
                    debugPrint("Item clicked! $item");
                    context.goNamed(
                      "details",
                      pathParameters: {
                        'title': item,
                      },
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            items.add("Item ${Random().nextInt(10)}");
          });
          debugPrint("new item added");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
