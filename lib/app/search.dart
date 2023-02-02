import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/todo.dart';
import 'package:todo_app/app/utils/logger.dart';

class SearchNotifier extends StateNotifier<List<Todo>> {
  SearchNotifier(this.ref) : super([]);
  final StateNotifierProviderRef<SearchNotifier, List<Todo>> ref;
  void search(String query) {
    if (query.isEmpty) {
      return;
    }
    state = ref
        .read(todoListProvider)
        .where((todo) => todo.description.contains(query))
        .toList();
    logger.v(state);
    logger.v(query);
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, List<Todo>>(
    (ref) => SearchNotifier(ref));
