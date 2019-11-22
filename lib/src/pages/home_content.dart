import 'package:bisma_certification/src/pages/detail_page.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                                        CupertinoPageRoute(
                                            builder: (context) => DetailPage()),
                                      );
                                    },
                                  ),
                                  FlatButton(
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        PageTransitionSlideLeft(
                                            page: DetailPage()),
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
    );
  }
}
