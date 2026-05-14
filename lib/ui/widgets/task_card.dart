import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/messenger.dart';
import 'package:task_manager/data/models/new_task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.newTaskModel, required this.index, required this.refreshList});

  final NewTaskModel newTaskModel;
  final VoidCallback refreshList;
  final int index;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isChangeStatusInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        tileColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.newTaskModel.title, style: textTheme.titleMedium),
            Text(widget.index.toString(), style: textTheme.bodySmall),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.newTaskModel.description, style: textTheme.bodyMedium),
            Text(
              'Create Date: ${widget.newTaskModel.createdDate}',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: Text(
                    widget.newTaskModel.status,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {
                    _showChangeStatusDialog();
                  },
                  icon: _isChangeStatusInProgress
                      ? CircularProgressIndicator()
                      : Icon(Icons.edit, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: _isCurrentStatus('New') ? Icon(Icons.check) : null,
                onTap: () {
                  _onTapChangeTaskTile('New');
                },
              ),
              ListTile(
                title: Text('Progress'),
                trailing: _isCurrentStatus('Progress')
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Progress');
                },
              ),
              ListTile(
                title: Text('Cancelled'),
                trailing: _isCurrentStatus('Cancelled')
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Cancelled');
                },
              ),
              ListTile(
                title: Text('Completed'),
                trailing: _isCurrentStatus('Completed')
                    ? Icon(Icons.check)
                    : null,
                onTap: () {
                  _onTapChangeTaskTile('Completed');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isCurrentStatus(String status) {
    return widget.newTaskModel.status == status;
  }

  void _onTapChangeTaskTile(String status) {
    if(_isCurrentStatus(status)) return;
    Navigator.pop(context);
    _changeStatus(status);
  }

  Future<void> _changeStatus(String status) async {
    _isChangeStatusInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.patchRequest(
      Urls.changeStatusUrl(widget.newTaskModel.id, status),
    );

    if(response.isSuccess){
      widget.refreshList();

    } else {
      _isChangeStatusInProgress = false;
      setState(() {});
      if(!mounted) return;
      Messenger.showErrorMessage(context, 'Something Went Wrong');
    }
  }
}
