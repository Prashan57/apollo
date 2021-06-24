import 'package:apollo/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = 'MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  PageController _c;
  @override
  void initState() {
    _c = new PageController(
      initialPage: _page,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myConstant.primaryColor,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.userCircle),
          onPressed: () {},
        ),
        title: Center(
          child: Text(
            'Apollo',
            style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: 30.0,
                fontWeight: FontWeight.w200),
          ),
        ),
        actions: [
          IconButton(
              icon: FaIcon(FontAwesomeIcons.connectdevelop), onPressed: () {})
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_fire_department_outlined,
              size: 30.0,
            ),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30.0,
            ),
            label: 'Favorites',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _page,
        selectedItemColor: Colors.white,
        backgroundColor: myConstant.primaryColor,
        unselectedItemColor: myConstant.primaryColorAlt,
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          this._c.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
      ),
      body: new PageView(
        controller: _c,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.supervised_user_circle),
                new Text("Users")
              ],
            ),
          ),
          new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.notifications),
                new Text("Alerts")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
