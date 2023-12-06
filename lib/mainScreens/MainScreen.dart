import 'package:crick_team/mainScreens/HomeScreen.dart';
import 'package:crick_team/mainScreens/MyMatches.dart';
import 'package:crick_team/mainScreens/ScoreScreen.dart';
import 'package:crick_team/utils/AppColor.dart';
import 'package:flutter/material.dart';

import 'Menu.dart';


class MainScreen extends StatefulWidget {
  late int index;
  late bool fromHome = false;

  MainScreen({Key? key, this.index = 2}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

/*  void onItem(int page) {
    index = page;
    fromHome = true;
    debugPrint("INdexx__$index");
  }*/
}

final GlobalKey<ScaffoldState> scaffoldKeys = GlobalKey<ScaffoldState>();

String userType = "";

class _MainScreenState extends State<MainScreen> {
  bool menuTapped = false;
  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ScoreScreen(),
    MyMatches()
  ];


  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {

    if (menuTapped == false) {
      _selectedIndex = 2;
    }
    _selectedIndex = (userType == "2")
        ? widget.index
        : (userType == "5" && widget.index == 3)
            ? widget.index
            : 0;
    debugPrint("INDEX___${widget.index}");
    debugPrint("SELECTED_INDEX___$_selectedIndex");
    debugPrint("USER_TYPE__$userType");
    // _selectedIndex = getIndex(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeys,
      drawer: Menu(
        bottomIndex: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      backgroundColor: AppColor.lightGrey,
      body:  _widgetOptions[_selectedIndex],
      bottomNavigationBar:  BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/home.png"),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/trophy.png"),
                    ),
                    label: 'My Matches'),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/scoreboard.png"),
                    ),
                    label: 'Scoreboard'),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColor.orange_light,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: (index) {
                _selectedIndex = index;
                setState(() {});
              },
            )

    );
  }
}