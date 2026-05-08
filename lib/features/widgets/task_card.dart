import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        tileColor: Colors.white,
        title: Text('Task $index', style: textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description of task $index', style: textTheme.bodyMedium),
            Text('Date: 8 May 2026', style: textTheme.bodySmall),
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
                    'New',
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
