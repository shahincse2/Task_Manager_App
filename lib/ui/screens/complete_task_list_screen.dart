import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/models/task_count_by_status.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class CompleteTaskListScreen extends StatefulWidget {
  const CompleteTaskListScreen({super.key});

  @override
  State<CompleteTaskListScreen> createState() => _CompleteTaskListScreenState();
}

class _CompleteTaskListScreenState extends State<CompleteTaskListScreen> {
  bool _isTaskSummaryLoading = false;
  bool _isTaskListLoadingInProgress = false;

  List<TaskCountByStatus> _taskCountByStatus = [];
  List<NewTaskModel> _completedTaskListByStatus = [];

  @override
  void initState() {
    // TODO: implement initState
    _getTaskListByStatus();
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getTaskListByStatus();
          _getCompletedTaskList();
        },
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              const SizedBox(),
              _isTaskSummaryLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildTaskSummaryListView(textTheme),
              _isTaskListLoadingInProgress
                  ? Column(
                children: [
                  const SizedBox(height: 240),
                  CircularProgressIndicator(),
                ],
              )
                  : ListView.separated(
                reverse: true,
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _completedTaskListByStatus.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    newTaskModel: _completedTaskListByStatus[index],
                    index: _completedTaskListByStatus.length - index,
                    refreshList: () {
                      _getCompletedTaskList();
                      _getTaskListByStatus();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskSummaryListView(TextTheme textTheme) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: _taskCountByStatus.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(left: 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text(
                    _taskCountByStatus[index].sum.toString(),
                    style: textTheme.bodyLarge,
                  ),
                  Text(
                    _taskCountByStatus[index].id,
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _getCompletedTaskList() async {
    _isTaskListLoadingInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.completedTaskListUrl,
    );

    if (response.isSuccess) {
      List<NewTaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(NewTaskModel.fromJson(jsonData));
      }
      _completedTaskListByStatus = list;
    } else {
      if (!mounted) return;
      Messenger.showErrorMessage(context, response.errorMessage);
    }
    _isTaskListLoadingInProgress = false;
    setState(() {});
  }

  Future<void> _getTaskListByStatus() async {
    _isTaskSummaryLoading = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskStatusCountUrl,
    );

    if (response.isSuccess) {
      List<TaskCountByStatus> list = [];
      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskCountByStatus.fromJson(jsonData));
      }
      _taskCountByStatus = list;
    } else {
      if (!mounted) return;
      Messenger.showErrorMessage(context, response.errorMessage);
    }
    _isTaskSummaryLoading = false;
    setState(() {});
  }
}
