import 'package:bisma_certification/src/pages/home/home_content.dart';
import 'package:bisma_certification/src/pages/myclass_page.dart';
import 'package:bisma_certification/src/pages/profile_page.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPrefs prefs = SharedPrefs();
  int _currentPage = 0;
  bool _isLogin;
  List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ProfilePage(),
    MyClass(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    // _initSP();
    initOneSignal();
  }

  Future<void> initOneSignal() async {
    const APP_ID = '77634abc-7dc4-4c8d-9f1c-64a469bb388e';

    print("Initiating OneSignal");
    OneSignal.shared.init(APP_ID);
    print("Succeed!");

    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // will be called whenever the subscription changes
      //(ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  _logoutProcess() {
    setState(() {
      prefs.delete('login').then((val) {
        _isLogin = val;
      });
      print("berhasil delet => $_isLogin");
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("uda di build $_isLogin");

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Bisma Certification",
      //     style: TextStyle(
      //       color: Colors.red[300],
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // body: ListView.builder(
      //   padding: EdgeInsets.symmetric(vertical: 16.0),
      //   itemBuilder: (BuildContext context, int index) {
      //     if(index % 2 == 0) {
      //       return _buildCarousel(context, index ~/ 2);
      //     }
      //     else {
      //       return Divider();
      //     }
      //   },
      // ),
      body: IndexedStack(
        index: _currentPage,
        children: _widgetOptions,
      ),
      extendBody: true,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => ProfilePage()));
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
          // if (index == 1) {
          //   Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => ProfilePage()));
          // }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            title: Text("My Class"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Carousel $carouselIndex'),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 200.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.8),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
            itemCount: 5,
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }
}
