import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:bisma_certification/src/pages/checkout_page.dart';
import 'package:bisma_certification/src/utils/bottom_sheet.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:bisma_certification/src/widgets/custom_shape_clipper.dart';
import 'package:http/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailPage extends StatefulWidget {
  final List<int> todos;
  final Certification certification;

  const DetailPage({Key key, this.todos, this.certification}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  SharedPrefs prefs = SharedPrefs();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  IconData favs = Icons.favorite_border;
  bool showBottomSheet = false, favsBool = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future isLoad() async {
    await Future.delayed(Duration(seconds: 1));
    return _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    print("ehehee coba yuk detilll =>>>> ${widget.certification}");
    final certification = widget.certification;
    return FutureBuilder(
        future: isLoad(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitPulse(color: Color(0xff0E4E95)),
                    SizedBox(height: 20),
                    Text("Getting Certification Detail"),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: bottomNavDetailPage(context, certification),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: certification.id,
                        child: ClipPath(
                          clipper: CustomShapeClipper(),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .4,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
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
                            child: CachedNetworkImage(
                              imageUrl: certification.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(
                                  Icons.error,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              BackButton(
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              BottomSheetCart(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      certification.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, -30, 0),
                                      child: Row(
                                        children: List.generate(5, (index) {
                                          return _generateStar(context, index,
                                              value: 3);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .85,
                                    child: Text(
                                      "Description",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .85,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        certification.description,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _generateStar(BuildContext context, int index, {int value}) {
    return Icon(
      Icons.star,
      size: 15,
      color: index < value ? Colors.amber : Colors.grey,
    );
  }

  _toggleFavs() {
    favsBool = !favsBool;
    setState(() {
      favs = (favsBool) ? Icons.favorite : Icons.favorite_border;
      return favs;
    });
  }

  Widget bottomNavDetailPage(context, Certification certification) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  // side: BorderSide(color: Colors.blue),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  setState(() {
                    // prefs.delete('cart');
                    prefs.addCart("cart", certification.id, value: {
                      certification.id: {
                        "image": certification.image,
                        "name": certification.name,
                        "price": certification.price,
                        "qty": 1,
                        "total": certification.price,
                      }
                    });
                    prefs
                        .readCart('cart')
                        .then((val) => print("ni lo ech => $val"));
                  });
                  final snackbar = SnackBar(
                      content: Text("Schema Programmer added to cart"));
                  _scaffoldKey.currentState.showSnackBar(snackbar);
                },
                color: Color(0xff5E4FD1),
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffF05052),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: _toggleFavs,
                  child: Icon(
                    favs,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
