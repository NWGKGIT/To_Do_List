import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> _taskList;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  /// Refreshes the list of tasks from the database.
  void _refreshTaskList() {
    setState(() {
      _taskList = _dbHelper.getTasks();
    });
  }

  /// Shows a dialog to add or update a task.
  void _showTaskDialog({Task? task}) {
    // If updating an existing task, pre-fill the text field.
    if (task != null) {
      _taskController.text = task.title;
    } else {
      _taskController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task == null ? 'New Task' : 'Edit Task'),
          content: TextField(
            controller: _taskController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Task Title'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _saveTask(task: task);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Saves a new task or updates an existing one.
  void _saveTask({Task? task}) async {
    final title = _taskController.text;
    if (title.isNotEmpty) {
      if (task == null) {
        // Create new task
        await _dbHelper.insertTask(Task(title: title));
      } else {
        // Update existing task
        task.title = title;
        await _dbHelper.updateTask(task);
      }
      _taskController.clear();
      _refreshTaskList();
    }
  }

  /// Toggles the completion status of a task.
  void _toggleTask(Task task) async {
    task.isDone = !task.isDone;
    await _dbHelper.updateTask(task);
    _refreshTaskList();
  }

  /// Deletes a task.
  void _deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task deleted'),
        duration: Duration(seconds: 1),
      ),
    );
    _refreshTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks'), centerTitle: true),
      body: FutureBuilder<List<Task>>(
        future: _taskList,
        builder: (context, snapshot) {
          // Show a loading indicator while fetching tasks.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Show an error message if something goes wrong.
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // Show a message if there are no tasks.
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet. Add one!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskTile(
                task: task,
                onCheckboxChanged: (value) => _toggleTask(task),
                onDeletePressed: () => _deleteTask(task.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: const Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }
}
