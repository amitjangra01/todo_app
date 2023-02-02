import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/todo.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
            onPressed: () => context.push('/searchPage'),
            icon: const Icon(Icons.today_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoListProvider.notifier).add(controller.text);
          controller.clear();
        },
        child: const Icon(Icons.done),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Type something',
                  labelText: 'Todo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          ...todos.map(
            (todo) => Dismissible(
              // onDismissed: (direction) =>
              //     ref.read(todoListProvider.notifier).remove(todo),
              key: ValueKey(todos.indexOf(todo)),
              child: Card(
                child: ListTile(
                  onTap: () {
                    showDialogueAlert(todo, context, ref);
                  },
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (b) {
                      ref.read(todoListProvider.notifier).toggle(todo.id ?? '');
                    },
                  ),
                  title: Text(todo.description),
                  trailing: IconButton(
                      onPressed: () {
                        ref.read(todoListProvider.notifier).remove(todo);
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future showDialogueAlert(
  Todo todo,
  BuildContext context,
  WidgetRef ref,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Todo'),
      content: TextFormField(
        initialValue: todo.description,
        decoration: const InputDecoration(),
        onChanged: (value) {
          todo.description = value;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('cancel'),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id ?? '', description: todo.description);
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    ),
  );
}
