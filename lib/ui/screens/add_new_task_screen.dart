import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/task_manager_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String routeName = '/add-new-task-screen';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  bool _isAddNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  TextFormField(
                    controller: _titleTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: true,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Title'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    enableSuggestions: true,
                    autocorrect: true,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _onTapAddNewTaskButton,
                    child: _isAddNewTaskInProgress
                        ? CircularProgressIndicator()
                        : Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _isAddNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTaskUrl,
      body: requestBody,
    );

    _isAddNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _clearTextFields();
      if (!mounted) return;
      Messenger.showSuccessMessage(context, 'New Task added successfully!');
    } else {
      if (!mounted) return;
      // if (response.responseCode == 401) {
      //   Messenger.showErrorMessage(context, response.errorMessage);
      // }
      Messenger.showErrorMessage(context, response.errorMessage);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
