import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_manager_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String routeName = '/add-new-task-screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const SizedBox(height: 36),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                TextFormField(decoration: InputDecoration(hintText: 'Title')),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(height: 8),
                FilledButton(onPressed: _onTapAddNewTaskButton, child: Text('Add Task'),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddNewTaskButton(){
    //TODO: Implement add new task functionality here
  }
}
