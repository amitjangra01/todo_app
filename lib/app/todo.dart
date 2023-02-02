import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/utils/logger.dart';
import 'package:uuid/uuid.dart';

Uuid _uuid = const Uuid();

class Todo {
  final String? id;
  String description;
  bool completed;
  Todo({
    String? id,
    this.description = '',
    this.completed = false,
  }) : id = id ?? _uuid.v4();

  // @override
  // String toString() {
  //   return 'Todo(description: $description, completed: $completed)';
  // }
}

class TodoStateNotifier extends StateNotifier<List<Todo>> {
  TodoStateNotifier([List<Todo>? initialState]) : super(initialState ?? []);

  void add(String description) {
    state = [...state, Todo(description: description)];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(id: todo.id, completed: todo.completed, description: description)
        else
          todo
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => target.id != todo.id).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoStateNotifier, List<Todo>>(
  (ref) => TodoStateNotifier(),
);

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider((_) => TodoListFilter.all);
