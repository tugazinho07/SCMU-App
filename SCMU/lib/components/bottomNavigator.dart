import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scmu/history.dart';
import 'package:scmu/list.dart';
import 'package:scmu/setings.dart';
import 'package:scmu/homepage.dart';



class MyBottomNavigator extends StatefulWidget {

  const MyBottomNavigator({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigator> createState() => _MyBottomNavigatorState();
}

class _MyBottomNavigatorState extends State<MyBottomNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePageApp(),
    listPage(),
    historyPage(),
    settingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          selectedIndex: _selectedIndex,
          onTabChange: (index){
            print(_selectedIndex);
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/Home');
                break;
              case 1:
                Navigator.pushNamed(context, '/Offices');
                break;
              case 2:
                Navigator.pushNamed(context, '/Historico');
                break;
              case 3:
                Navigator.pushNamed(context, '/Settings');
                break;
            }

          },
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
        ),
      ),
    );
  }
}
