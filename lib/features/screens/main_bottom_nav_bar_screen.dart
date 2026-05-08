import 'package:flutter/material.dart';
import 'package:task_manager/features/screens/canceled_task_list_screen.dart';
import 'package:task_manager/features/screens/complete_task_list_screen.dart';
import 'package:task_manager/features/screens/new_task_list_screen.dart';
import 'package:task_manager/features/screens/progress_task_list_screen.dart';
import 'package:task_manager/features/widgets/task_manager_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  static const String routeName = '/main-bottom-nav-bar-screen';

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
      NewTaskListScreen(),
      ProgressTaskListScreen(),
      CanceledTaskListScreen(),
      CompleteTaskListScreen(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Canceled',
          ),
          NavigationDestination(
            icon: Icon(Icons.done_all_outlined),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
