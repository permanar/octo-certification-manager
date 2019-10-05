import 'package:bisma_certification/src/styles.dart';
import 'package:flutter/material.dart';

class OnBoardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const OnBoardingContent({Key key, this.image, this.title, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              image,
              height: 300,
              width: 300,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: onBoardingTitleStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            desc,
            style: onBoardingSubtitleStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
