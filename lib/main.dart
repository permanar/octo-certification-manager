import 'dart:io';

import 'package:bisma_certification/src/pages/home_page.dart';
import 'package:bisma_certification/src/pages/onboarding/onboarding_page.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SharedPrefs prefs = SharedPrefs();

  Future<bool> _initBro() async {
    var redirect = await prefs.readBool("onboard") ?? false;
    print("main => $redirect");
    // return Future.delayed(Duration(seconds: 7), () => redirect);
    return redirect;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'CM Sans Serif',
        platform: TargetPlatform.android,
      ),
      home: FutureBuilder(
        future: _initBro(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            print("main inside => ${snapshot.data}");
            return snapshot.data ? HomePage() : OnBoardingPage();
          } else {
            return Scaffold(
              body: Container(
                child: Center(
                  // child: SpinKitFadingFour(
                  //   color: Colors.black,
                  //   controller: AnimationController(
                  //     duration: Duration(seconds: 2400),
                  //   ),
                  // ),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
