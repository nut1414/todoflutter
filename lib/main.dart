import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/todoItem.dart';
import 'widgets/todoaddmenu.dart';

import 'models/todo.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>('todo');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Todo>('todo');

    void create_todo(String title,String description,bool isComplete) {
      final todo = Todo()
        ..title = title
        ..description = description
        ..isComplete = isComplete;
      box.add(todo);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, box, widget) {
          return box.length > 0 ? ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final todo = box.getAt(index);
              if (todo == null) {
                return const SizedBox.shrink();
              }
              return TodoItem(
                title: todo.title, 
                description: todo.description, 
                isComplete: todo.isComplete, 
                onDelete: () {
                  todo.delete();
                }, 
                onSetComplete: (value) {
                    todo.isComplete = value;
                    todo.save();
                },
              );
            }
          ) : const Center(child: Text("Push the + button to add a todo", style: TextStyle(color: Colors.grey),));
        }
        // ListView.builder(
        //     itemCount: box.length,
        //     itemBuilder: (context, index) {
        //       final todo = box.getAt(index);
        //       if (todo == null) {
        //         return const SizedBox.shrink();
        //       }
        //       return TodoItem(
        //         title: todo.title, 
        //         description: todo.description, 
        //         isComplete: todo.isComplete, 
        //         onDelete: () {
        //           todo.delete();
        //         }, 
        //         onSetComplete: (value) {
        //             todo.isComplete = value;
        //             todo.save();
        //         },
        //       );
        //     }
        //   ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  TodoAddForm(addtodo:create_todo)),
          );
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


