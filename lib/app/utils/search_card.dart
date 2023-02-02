import 'package:flutter/material.dart';

import '../todo.dart';

class SearchCard extends StatelessWidget {
  final Todo todo;
  const SearchCard(
    this.todo, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.view_agenda)),
        title: Text(todo.description),
      ),
    );
  }
}