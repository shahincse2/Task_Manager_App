import 'package:flutter/material.dart';
import 'package:task_manager/data/models/new_task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.newTaskModel, required this.index});

  final NewTaskModel newTaskModel;
  final int index;

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
            Text(newTaskModel.title, style: textTheme.titleMedium),
            Text(index.toString(), style: textTheme.bodySmall),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(newTaskModel.description, style: textTheme.bodyMedium),
            Text('Create Date: ${newTaskModel.createdDate}', style: textTheme.bodySmall),
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
                    newTaskModel.status,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
