import 'package:ecomerce_app_two/screens/homescreen/home_screen.dart';
import 'package:ecomerce_app_two/screens/main_tab/bookmark_screen.dart';
import 'package:ecomerce_app_two/screens/main_tab/notification_screen.dart';
import 'package:ecomerce_app_two/screens/main_tab/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {

  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    BookmarkScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            selectedIndex: _currentIndex,
            gap: 8,
            color: const Color(0xFF9DB2CE), 
            activeColor: Colors.black,
            iconSize: 24,
            padding: EdgeInsets.all(16),
            // ignore: deprecated_member_use
            tabBackgroundColor: Colors.black.withOpacity(0.06),
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
                // print(index);
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.bookmark,
                text: 'Bookmark',
              ),
              GButton(
                icon: Icons.notification_add,
                text: 'Notification',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}