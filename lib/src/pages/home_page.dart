import 'package:bisma_certification/src/pages/login_page.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPrefs prefs = SharedPrefs();
  int _currentPage = 0;
  bool _isLogin;

  @override
  void initState() {
    super.initState();
    _initSP();
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

  // Checking if login not proceed at the very beginning, go directly to the login page
  // Still not sure about this idea but, let's give it a shot
  _initSP() {
    prefs.read('login').then((val) {
      _isLogin = val;
      if (_isLogin != true) {
        print("mantaapp if condt true homepage!!! => $_isLogin)}");
        setState(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        });
      }
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
      appBar: AppBar(
        title: Text(
          "Bisma Certification",
          style: TextStyle(
            color: Colors.red[300],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
      body: Container(
        child: Column(
          // overflow: Overflow.visible,
          children: [
            Container(
              height: 150,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.network(
                    "http://via.placeholder.com/350x150",
                    fit: BoxFit.fill,
                  );
                },
                itemCount: 5,
                viewportFraction: 0.8,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: SwiperPagination.dots,
                ),
                control: SwiperControl(
                  iconNext: Icons.navigate_next,
                  iconPrevious: Icons.navigate_before,
                ),

                scale: 0.9,
                autoplay: true,
                // duration: 3000,
                fade: .2,
                loop: false,
                curve: Curves.ease,
                // layout: SwiperLayout.STACK,
                itemWidth: 300,
                itemHeight: 150,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.pink,
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album, size: 70),
                              title: Text('Heart Shaker',
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text('TWICE',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            ButtonTheme.bar(
                              child: ButtonBar(
                                children: <Widget>[
                                  FlatButton(
                                    child: const Text('Edit',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext build) =>
                                              MySecondPage(
                                            todos: List.generate(
                                              10,
                                              (i) => i,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext build) =>
                                              MySecondPage(
                                            todos: List.generate(
                                              10,
                                              (i) => i,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text("data"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _logoutProcess,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
          print(index);
          if (index == 1) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
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

class MySecondPage extends StatefulWidget {
  final List<int> todos;

  const MySecondPage({Key key, this.todos}) : super(key: key);

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("datas"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.todos.length,
          itemBuilder: (BuildContext context, int id) {
            return ListTile(
              title: Text("${widget.todos[id]}"),
            );
          },
        ),
      ),
    );
  }
}
