import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/new_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    NewTaskScreen(),
    NewTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.ac_unit_sharp),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Complete'),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancel',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
