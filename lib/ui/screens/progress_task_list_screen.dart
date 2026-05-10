import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
