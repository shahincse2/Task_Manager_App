import 'package:flutter/material.dart';
import 'package:task_manager/features/widgets/task_card.dart';

class CompleteTaskListScreen extends StatefulWidget {
  const CompleteTaskListScreen({super.key});

  @override
  State<CompleteTaskListScreen> createState() => _CompleteTaskListScreenState();
}

class _CompleteTaskListScreenState extends State<CompleteTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            const SizedBox(),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return TaskCard(index: index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
