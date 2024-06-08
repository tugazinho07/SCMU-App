import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scmu/history.dart';
import 'package:scmu/list.dart';
import 'package:scmu/main.dart';
import 'package:scmu/setings.dart';
import 'package:scmu/pages/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageApp extends StatefulWidget {
   HomePageApp({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePageApp> createState() => _HomePageState();
}

void signUserOut(){
  FirebaseAuth.instance.signOut();
}


class _HomePageState extends State<HomePageApp>{
   int _selectedIndex = 0;
  void _openDoor() {
    // Add your implementation here
    print('Door opened');
  }

  void _toggleLight() {
    // Add your implementation here
    print('Light toggled');
  }
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

   final List<Widget> _screens = [
     StartingPage(),
     listPage(),
     historyPage(),
     settingsPage(),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text(
              'SCMU 23/24',
              style: TextStyle(color: Colors.white
              ),
            ),
            Spacer(),
            Text(
                'Logout',
                style: TextStyle(color: Colors.white,
                ),
            )
          ],
        ),
        actions: const [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout),color: Colors.white,)],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.maps_home_work_sharp,
                text: 'Offices',
              ),
              GButton(
                icon: Icons.history,
                text: 'Historico',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

}