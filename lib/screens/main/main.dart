import 'package:flutter/material.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/screens/home/home.dart';
import 'package:monexo/screens/settings/settings.dart';
import 'package:monexo/screens/statistics/statistics.dart';

/// Головна сторінка додатку - на ній розміщуються всі основні екрани додатку
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static final String routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StatisticsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          /// Головна сторінка
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: S.of(context).home,
          ),

          /// Статистика
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: S.of(context).statistics,
          ),

          /// Налаштування
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: S.of(context).settingUp,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
