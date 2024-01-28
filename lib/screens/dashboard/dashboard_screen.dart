// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_node_store/routes/app_router.dart';
import 'package:flutter_node_store/screens/bottomnav/home_screen.dart';
import 'package:flutter_node_store/screens/bottomnav/notification_screen.dart';
import 'package:flutter_node_store/screens/bottomnav/profile_screen.dart';
import 'package:flutter_node_store/screens/bottomnav/report_screen.dart';
import 'package:flutter_node_store/screens/bottomnav/setting_screen.dart';
import 'package:flutter_node_store/themes/colors.dart';
import 'package:flutter_node_store/utils/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _title = "Home";
  int _currentIndex = 2;

  final List<Widget> _pages = [
    ReportScreen(),
    NotificationScreen(),
    HomeScreen(),
    SettingScreen(),
    ProfileScreen(),
  ];

  void onTapped(int index) {
    setState(
      () {
        _currentIndex = index;
        switch (index) {
          case 0:
            _title = "Notification";
            break;
          case 1:
            _title = "Report";
            break;
          case 2:
            _title = "Home";
            break;
          case 3:
            _title = "Setting";
            break;
          case 4:
            _title = "Profile";
        }
      },
    );
  }

  Future<void> _handlerLogout() async {
    await MySharedPreferences.removeSharedPreference('token');
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        width: 250,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("nayok prayut"),
                  accountEmail: Text("nayok@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/samitk.jpg'),
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/samitk.jpg'),
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('info'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('About'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text('email'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(Icons.exit_to_app_outlined),
                    title: Text('Logout'),
                    onTap: () => _handlerLogout(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        onTap: (value) {
          onTapped(value);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: primaryDark,
        unselectedItemColor: primaryLight,
      ),
    );
  }
}
