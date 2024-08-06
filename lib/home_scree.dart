import 'package:flutter/material.dart';
import 'package:todo_app/tabs/Settings/Settings_Tab.dart';
import 'package:todo_app/tabs/Tasks/Add_Task_BottomSheet.dart';
import 'package:todo_app/tabs/Tasks/Tasks_Tab.dart';

class HomeScreen extends StatefulWidget {
  static const String reoutename = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;
  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedindex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => TaskBottomSheet(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.transparent,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
            currentIndex: selectedindex,
            onTap: (value) {
              selectedindex = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ]),
      ),
    );
  }
}
