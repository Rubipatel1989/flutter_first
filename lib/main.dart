import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiBaseUrl = "https://jsonplaceholder.typicode.com/todos/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Users List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List todos = [];
  bool isLoading = true;
  String selectedTodo = "";

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      final response =
          await http.get(Uri.parse(apiBaseUrl)).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        setState(() {
          todos = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchTodoDetails(int id) async {
    final response = await http.get(Uri.parse("$apiBaseUrl$id"));
    if (response.statusCode == 200) {
      setState(() {
        selectedTodo = jsonDecode(response.body)['title'];
      });
    } else {
      throw Exception('Failed to load todo details');
    }
  }

  Future<void> addTodo() async {
    final response = await http.post(
      Uri.parse(apiBaseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": "New Task", "completed": false}),
    );
    if (response.statusCode == 201) {
      setState(() {
        todos.insert(0, jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to add todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(todos[index]['title']),
                        subtitle: Text("ID: ${todos[index]['id']}"),
                        onTap: () => fetchTodoDetails(todos[index]['id']),
                      );
                    },
                  ),
                ),
                selectedTodo.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Selected Todo: $selectedTodo",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
