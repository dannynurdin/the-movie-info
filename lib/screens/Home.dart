import 'package:dicoding_submission_danny/screens/About.dart';
import 'package:dicoding_submission_danny/screens/Listview.dart';
import 'package:dicoding_submission_danny/screens/MovieDetail.dart';
import 'package:dicoding_submission_danny/screens/Search.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    Example(),
    Search(),
    About(),
    // MovieDetail(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _children[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',

          ),
        ],
        selectedItemColor: Colors.red,
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,

        onTap: onItemTapped,
      ),
    );
  }
}
