import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:matcher/matcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'table_page.dart';
import 'standings_page.dart';
import 'bookmark_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;
  final screens = [StandingsPage(), BookmarkPage()];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xffd73b53),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xffd73b53),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Bookmark',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTap,
          ),
        ),
        body: screens[_selectedIndex],
      ),
    );
  }
}
