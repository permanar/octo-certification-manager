import 'package:bisma_certification/src/pages/home_page.dart';
import 'package:bisma_certification/src/pages/sign_up_page.dart';
import 'package:bisma_certification/src/themes/custom_icons.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:bisma_certification/src/widgets/SocialIcons.dart';
import 'package:bisma_certification/src/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPrefs prefs = SharedPrefs();
  bool _isSelected = false;
  Future<dynamic> _isLogin;

  void _circleRadioTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  _initSP() {
    bool _isLoginz;
    prefs.read('login').then((val) => {_isLoginz = val});
    if (_isLoginz == true) {
      print("mantaapp if true loginpageee broo!!! => $_isLoginz)}");
      setState(() {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      });
    }
  }

  void _loginProcess() {
    try {
      prefs.add('login', true);
      _isLogin = prefs.read('login');
      // _isLogin = true;
      print("apasih isinya _isLogin ni kle | try => $_isLogin");

      if (_isLogin != null) {
        setState(() {
          print("Login ape ndak => $_isLogin");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        });
      }
    } catch (e) {
      print("apasih isinya _isLogin ni kle | throw => ${prefs.read('login')}");
      print(e);
    }
  }

  Widget _circleRadio(isSelected) {
    return Container(
      width: 16,
      height: 16,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2)),
      child: _isSelected
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            )
          : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initSP();

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset("assets/images/image_01.png"),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Image.asset(
                "assets/images/image_02.png",
                // height: 150,
              ),
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 60, bottom: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Image.asset(
                          "assets/images/logo-oende.png",
                          width: ScreenUtil.getInstance().setWidth(110),
                          height: ScreenUtil.getInstance().setHeight(110),
                        ),
                        onTap: _loginProcess,
                      ),
                      Text(
                        "OENDE",
                        style: TextStyle(
                          fontFamily: "Poppins-Bold",
                          fontSize: ScreenUtil.getInstance().setSp(46),
                          color: Colors.black,
                          letterSpacing: .6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  FormCard(),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: _circleRadioTap,
                                child: Row(
                                  children: <Widget>[
                                    _circleRadio(_isSelected),
                                    SizedBox(
                                      width: ScreenUtil.getInstance()
                                          .setHeight(10),
                                    ),
                                    Text(
                                      "Remember Me",
                                      style: TextStyle(
                                        fontFamily: "Poppins-bold",
                                        fontSize:
                                            ScreenUtil.getInstance().setSp(23),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: ScreenUtil.getInstance().setWidth(330),
                                  height:
                                      ScreenUtil.getInstance().setHeight(100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.99),
                                        offset: Offset(0, 8),
                                        blurRadius: 10,
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF17ead9),
                                        Color(0xFF6078ea)
                                      ],
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      child: Center(
                                        child: Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-bold",
                                            fontSize: 18,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text("Social Login"),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcons(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
                      SocialIcons(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcons(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.gplus,
                        onPressed: () {},
                      ),
                      SocialIcons(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransitionEnterExit(
                                  exitPage: LoginPage(),
                                  enterPage: SignUpPage()));
                        },
                        child: Text(
                          "Sign Up!",
                          style: TextStyle(
                            fontFamily: "Poppins-bolB",
                            color: Color(0xFF5d74e3),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
