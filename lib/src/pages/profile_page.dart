import 'package:bisma_certification/src/widgets/timeline.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProfilePage extends StatefulWidget {
  final int currentPage;

  const ProfilePage({Key key, this.currentPage = 0}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PageController _pageController;
  List title;
  // static List asd = [1, 2, 3, "asd"];
  final int _numPages = 4;
  int _currentPage;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);
    title = [
      'About',
      'Certificate',
      'Setting',
      'Completion',
    ];
    _currentPage = widget.currentPage;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _buildTabBarView() {
    List<Widget> list = [];
    for (var i = 0; i < _numPages; i++) {
      list.add(i == _currentPage
          ? _tabBarView(true, i, title[i])
          : _tabBarView(false, i, title[i]));
    }
    return list;
  }

  Widget _tabBarView(bool isActive, int id, String title) {
    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          id,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            color: isActive ? Colors.black26 : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF3C5AC8),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Richie Permana",
                          style: TextStyle(
                            color: Color.fromARGB(200, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 30),
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 155,
                                width: 155,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500)),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 125,
                                width: 125,
                                margin: const EdgeInsets.only(top: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500)),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 115,
                                width: 115,
                                margin: const EdgeInsets.only(top: 20),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(500)),
                                  child: Image(
                                    image: CachedNetworkImageProvider(
                                        "https://media.licdn.com/dms/image/C5103AQEL4MVxtgC6UQ/profile-displayphoto-shrink_200_200/0?e=1577318400&v=beta&t=TpxcHUstE_M7F77Xshwb2x16cHjdmjnaMEOz6iNx378"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints.expand(),
                          ),
                        ),
                        Container(
                          height: 50,
                          // margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF3C5AC8),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50)),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _buildTabBarView(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 242, 219),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(50)),
                    ),
                    // transform: Matrix4.translationValues(0, -50, 0),
                  ),
                  Container(
                    height: 200,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        ListView(
                          children: <Widget>[
                            Timeline(
                              children: <Widget>[
                                Container(
                                    height: 100, color: Colors.blueAccent),
                                Container(height: 50, color: Colors.blueAccent),
                                Container(
                                    height: 200, color: Colors.blueAccent),
                                Container(
                                    height: 100, color: Colors.blueAccent),
                              ],
                              indicators: <Widget>[
                                Icon(Icons.access_alarm),
                                Icon(Icons.backup),
                                Icon(Icons.accessibility_new),
                                Icon(Icons.access_alarm),
                              ],
                            ),
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                            Center(child: Text("Richie Permana")),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Center(child: Text("Richie Permana")),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Center(child: Text("Richie Permana")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
