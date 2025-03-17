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
      title: 'Flutter API Pagination',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Paginated Todo List'),
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
  int currentPage = 0; // Tracks the current page
  final int itemsPerPage = 10; // Number of items per page

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  /// Fetch the complete todo list
  Future<void> fetchTodos() async {
    print("Fetching todos from API...");

    try {
      final response = await http.get(Uri.parse(apiBaseUrl)).timeout(const Duration(seconds: 10));
      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List decodedData = jsonDecode(response.body);
        setState(() {
          todos = decodedData;
          isLoading = false;
        });
      } else {
        print("Failed to load todos, status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching todos: $error");
    }
  }

  /// Fetch details of a single todo and show in popup
  Future<void> fetchTodoDetails(int id) async {
    print("Fetching todo details for ID: $id");

    try {
      final response = await http.get(Uri.parse("$apiBaseUrl$id")).timeout(const Duration(seconds: 10));
      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> todo = jsonDecode(response.body);
        showTodoPopup(todo);
      } else {
        print("Failed to load todo details, status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching todo details: $error");
    }
  }

  /// Show the todo details in a popup
  void showTodoPopup(Map<String, dynamic> todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("User Details - ID: ${todo['id']}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title: ${todo['title']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Completed: ${todo['completed'] ? "Yes" : "No"}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  /// Get paginated data
  List getPaginatedTodos() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return todos.sublist(startIndex, endIndex > todos.length ? todos.length : endIndex);
  }

  /// Move to the next page
  void nextPage() {
    if ((currentPage + 1) * itemsPerPage < todos.length) {
      setState(() {
        currentPage++;
      });
    }
  }

  /// Move to the previous page
  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
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
                    itemCount: getPaginatedTodos().length,
                    itemBuilder: (context, index) {
                      final todo = getPaginatedTodos()[index];
                      return ListTile(
                        title: Text(todo['title']),
                        subtitle: Text("ID: ${todo['id']}"),
                        onTap: () => fetchTodoDetails(todo['id']),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: previousPage,
                        child: const Text("Previous"),
                      ),
                      Text("Page ${currentPage + 1}"),
                      ElevatedButton(
                        onPressed: nextPage,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
