import 'package:bisma_certification/src/pages/home/home_page.dart';
import 'package:bisma_certification/src/pages/login_page.dart';
import 'package:bisma_certification/src/pages/onboarding/onboarding_content.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  SharedPrefs prefs = SharedPrefs();
  final int _numPages = 3;
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // _getStarted();
  }

  void _getStarted() {
    print("initstate onboard");
    prefs.readBool("onboard").then((val) {
      if (val) {
        print("ooo yeaaaa onboard borr =>> $val");
        return Navigator.of(context)
            .pushReplacement(PageTransitionSlideLeft(page: HomePage()));
      }
      return null;
    });
  }

  List<Widget> _buildIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true, i) : _indicator(false, i));
    }
    return list;
  }

  Widget _indicator(bool isActive, int id) {
    return InkWell(
      onTap: () {
        _pageController.animateToPage(
          id,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 10,
        width: isActive ? 24 : 16,
        decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              stops: [.1, .4, .7, .9],
              colors: [
                Color(0xff3584dd),
                Color(0xff4563db),
                Color(0xff5036d5),
                Color(0xff5b16d0)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        _numPages,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    child: _currentPage != _numPages - 1
                        ? Text(
                            "Skip",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : Text(''),
                  ),
                ),
                Container(
                  height: .77 * MediaQuery.of(context).size.height,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      OnBoardingContent(
                        image: "assets/images/onboarding0.png",
                        title: "Connect people arround campus",
                        desc:
                            "Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet.",
                      ),
                      OnBoardingContent(
                        image: "assets/images/onboarding1.png",
                        title: "Connect people arround campus",
                        desc:
                            "Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet.",
                      ),
                      OnBoardingContent(
                        image: "assets/images/onboarding2.png",
                        title: "Connect people arround campus",
                        desc:
                            "Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet Lorem ipsum dor silit not amet.",
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? new NextButton(pageController: _pageController)
                    : Text("")
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? InkWell(
              onTap: () {
                gotoNextPage(context);
              },
              child: Container(
                height: .1 * MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }

  void gotoNextPage(BuildContext context) {
    // Navigator.of(context).pushReplacement(
    //   CupertinoPageRoute(
    //     builder: (context) => HomePage(),
    //   ),
    // );

    prefs.addBool("onboard", true);
    prefs.readBool('login').then((val) {
      if (val != true) {
        setState(() {
          Navigator.of(context)
              .pushReplacement(PageTransitionSlideLeft(page: LoginPage()));
        });
      } else {
        Navigator.of(context)
            .pushReplacement(PageTransitionSlideLeft(page: HomePage()));
      }
    });
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
    @required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: FlatButton(
          onPressed: () {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Icon(
                  Icons.arrow_forward,
                  size: 28,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
