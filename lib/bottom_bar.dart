import 'package:beloved_care/consts/my_icons.dart';
import 'package:beloved_care/screens/announcements/announcements.dart';
import 'package:beloved_care/screens/landingPage.dart';
import 'package:beloved_care/search.dart';
import 'package:beloved_care/user_info.dart';
import 'package:flutter/material.dart';
import 'feeds.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  late List pages;
  @override
  void initState() {
    pages = [
      LandingPage(),
      Feeds(),
      Search(),
      Announcements(),
      // CartScreen(),
      UserInfo(),
    ];
    // _pages = [
    //   {
    //     'page': Home(),
    //   },
    //   {
    //     'page': Feeds(),
    //   },
    //   {
    //     'page': Search(),
    //   },
    //   {
    //     'page': CartScreen(),
    //   },
    //   {
    //     'page': UserInfo(),
    //   },
    // ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPageIndex,
              // selectedLabelStyle: TextStyle(fontSize: 16),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.home),
                  // title: Text('Home'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.room_service), label: 'Services'),
                BottomNavigationBarItem(
                    activeIcon: null, icon: Icon(null), label: 'Occasions'),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyAppIcons.bag,
                    ),
                    label: 'Notice Board'),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.user), label: 'User'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(MyAppIcons.search),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}
