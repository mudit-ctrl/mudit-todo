import 'package:flutter/material.dart';
import 'package:todoapp/screen/todocard.dart';

class Entryscreen extends StatefulWidget {
  const Entryscreen({super.key});

  @override
  State<Entryscreen> createState() => _EntryscreenState();
}

class _EntryscreenState extends State<Entryscreen> {
  List<String> tasks = [];
  List<String> filteredTasks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTasks = tasks;
    _searchController.addListener(_filterTasks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTasks() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      filteredTasks =
          tasks.where((task) => task.toLowerCase().contains(query)).toList();
    });
  }

  void _addTask(String task) {
    setState(() {
      tasks.insert(0, task); // Insert new task at the beginning of the list
      filteredTasks = tasks; // Update filteredTasks when a new task is added
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Remove the task at the specified index
      filteredTasks = tasks; // Update filteredTasks when a task is deleted
    });
  }

  void _showAddTaskModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        TextEditingController _taskController = TextEditingController();

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addTask(value);
                      Navigator.pop(context); // Close the modal bottom sheet
                    }
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    String task = _taskController.text;
                    if (task.isNotEmpty) {
                      _addTask(task);
                      Navigator.pop(context); // Close the modal bottom sheet
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskModal,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'All ToDos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  return Todocard(
                    todotitle: filteredTasks[index],
                    onDelete: () {
                      _deleteTask(tasks.indexOf(
                          filteredTasks[index])); // Delete from original list
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
