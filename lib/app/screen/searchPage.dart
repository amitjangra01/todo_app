// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/utils/logger.dart';

import '../search.dart';
import '../utils/search_card.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(searchProvider);
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  ref.read(searchProvider.notifier).search(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Search todos'),
              ),
            ),
            
            if (todos.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                  'Matching search results :-',
                  textScaleFactor: 1.1,
                ),
              ),
            ...todos.map((todo) => SearchCard(todo)).toList(),
          ],
        ),
      ),
    );
  }
}
