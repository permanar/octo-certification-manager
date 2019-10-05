import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 15),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                  fontFamily: "Poppins-bold",
                  letterSpacing: .6,
                  fontSize: ScreenUtil.getInstance().setSp(45),
                  color: Colors.black),
            ),
            Text(
              "Sign in and let us do your certification management!",
              style: TextStyle(
                  fontFamily: "Poppins-medium",
                  fontSize: ScreenUtil.getInstance().setSp(20),
                  color: Colors.blueGrey),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(
              "Username",
              style: TextStyle(
                fontFamily: "Poppins-medium",
                letterSpacing: .6,
                fontSize: ScreenUtil.getInstance().setSp(25),
                color: Colors.black,
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text(
              "Password",
              style: TextStyle(
                fontFamily: "Poppins-medium",
                letterSpacing: .6,
                fontSize: ScreenUtil.getInstance().setSp(25),
                color: Colors.black,
              ),
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(45),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontFamily: "Poppins-medium",
                      color: Colors.blue,
                      fontSize: ScreenUtil.getInstance().setSp(25)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
