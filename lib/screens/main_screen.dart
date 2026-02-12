import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';
import '../tabs/student_list_tab.dart';
import '../tabs/settings_tab.dart';
import '../tabs/other_tabs.dart';
import '../tabs/exam_schedule_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const StudentListTab(),
    const ScheduleTab(),
    const ExamScheduleTab(),
    const GroupInfoTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitleForIndex(context, _selectedIndex)),
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed, // Quan trọng để hiện đủ 5 tab
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.people),
            label: AppLocalizations.t(context, 'students'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            label: AppLocalizations.t(context, 'schedule'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment_turned_in_outlined),
            label: AppLocalizations.t(context, 'exams'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.groups),
            label: AppLocalizations.t(context, 'group'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.t(context, 'settings'),
          ),
        ],
      ),
    );
  }

  String _getTitleForIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        return AppLocalizations.t(context, 'students');
      case 1:
        return AppLocalizations.t(context, 'schedule');
      case 2:
        return AppLocalizations.t(context, 'exams');
      case 3:
        return AppLocalizations.t(context, 'group');
      case 4:
        return AppLocalizations.t(context, 'settings');
      default:
        return 'App';
    }
  }
}
