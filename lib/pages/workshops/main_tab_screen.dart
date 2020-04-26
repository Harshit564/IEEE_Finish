import 'package:flutter/material.dart';

import 'package:ieeepecstudentdeadline/pages/workshops/cs_workshops.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/pes_workshops.dart';
import 'package:ieeepecstudentdeadline/pages/workshops/wie_workshops.dart';

class TabScreen extends StatefulWidget {
  static const String routeName = "/tab-screen";

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Workshops',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new DefaultTabController(
        length: 3,
        child: new Column(
          children: <Widget>[
            new Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: new Material(
                //color: Colors.white,
                child: new TabBar(
                  //indicatorColor: Color(0xff5cb3bc),
                  //labelColor: Colors.white,
                  unselectedLabelColor: Color(0xffCBE7EA),
                  indicator: BoxDecoration(
                    color: Color(0xffCBE7EA),
                  ),
                  tabs: [
                    new Tab(
                      icon: new Icon(Icons.computer),
                      text: "CS",
//                      child: Container(color: Color(0xFF01588D),),
                    ),
                    new Tab(
                      icon: new Icon(Icons.insert_emoticon),
                      text: "WIE",
                    ),
                    new Tab(
                      icon: new Icon(Icons.power),
                      text: "PES",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            new Expanded(
              child: new TabBarView(
                children: [
                  CSWorkshopsPage(),
                  WIEWorkshopsPage(),
                  PESWorkshopsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
  final List<Map<String, Object>> _pages = [
    {
      'page': CSWorkshopsPage(),
      'appBarTitle': 'CS Workshops',
    },
    {
      'page': WIEWorkshopsPage(),
      'appBarTitle': 'WIE Workshops',
    },
    {
      'page': PESWorkshopsPage(),
      'appBarTitle': 'PES Workshops',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
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
              icon: Icon(Icons.code),
              title: Text(
                'CS',
                style: TextStyle(
                    fontFamily: 'Montsserat'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text(
                'WIE',
                style: TextStyle(
                    fontFamily: 'Montsserat'),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text(
                'PES',
                style: TextStyle(
                    fontFamily: 'Montsserat'),
              )),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }

 */
}
