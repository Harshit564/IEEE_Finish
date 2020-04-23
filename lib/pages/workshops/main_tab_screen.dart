import 'package:ieeepecstudentdeadline/pages/workshops/cs_workshops.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/pes_worshops.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/wie_workshops.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {

  static const String routeName = "/tab-screen";

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  final List<Map<String, Object>>_pages = [
    {
      'page' : CSWorkshopsPage(),
      'appBarTitle' : 'CS Workshops' ,
    },
    {
      'page' : WIEWorkshopsPage(),
      'appBarTitle' : 'WIE Workshops' ,
    },
    {
      'page' : PESWorkshopsPage(),
      'appBarTitle' : 'PES Workshops' ,
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_pages[_selectedPageIndex]['appBarTitle']),
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color(0xffCBE7EA),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xff5cb3bc),
        currentIndex: _selectedPageIndex,

        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.near_me),
              title: Text('CS')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text('WIE')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text('PES')
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}
