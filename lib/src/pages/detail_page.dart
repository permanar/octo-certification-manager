import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:bisma_certification/src/pages/checkout_page.dart';
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
                              GestureDetector(
                                onTap: () {
                                  bottomSheetCart(context, certification);
                                },
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
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

  bottomSheetCart(BuildContext context, Certification certification) async {
    // var carts = await prefs.readCart("cart");

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "My Cart",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 195,
                          child: FutureBuilder(
                            future: buildShopCart(setModalState, certification),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data;
                              } else {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SpinKitPulse(color: Color(0xff0E4E95)),
                                      SizedBox(height: 20),
                                      Text("Loading Cart....."),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Divider(),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Subtotal:"),
                                  FutureBuilder(
                                    future: prefs.readCart('cart'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        int total = 0;

                                        for (var item in snapshot.data) {
                                          print(item);
                                          total += int.parse(
                                              item[item.keys.first]['total']);
                                        }
                                        print(
                                            'this is me snapshut =>>> ${snapshot.data}');

                                        FlutterMoneyFormatter fmf =
                                            FlutterMoneyFormatter(
                                          amount:
                                              double.parse(total.toString()),
                                          settings: MoneyFormatterSettings(
                                            symbol: "IDR",
                                            thousandSeparator: ".",
                                            decimalSeparator: ",",
                                            symbolAndNumberSeparator: " ",
                                          ),
                                        );

                                        return Text(
                                            "Rp. ${fmf.output.nonSymbol}");
                                      } else {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SpinKitPulse(
                                                  color: Color(0xff0E4E95)),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff5E4FD1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: FlatButton(
                                  onPressed: () {
                                    // _makePayment();
                                    setState(() {
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                        PageTransitionSlideLeft(
                                            page: CheckoutPage()),
                                      );
                                    });
                                  },
                                  highlightColor: Colors.transparent,
                                  child: Text(
                                    "Checkout",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future _makePayment() async {
    HttpClient httpClient = new HttpClient();
    String url = "https://api.sandbox.midtrans.com/v2/charge";

    var json = jsonEncode({
      "payment_type": "bank_transfer",
      "bank_transfer": {"bank": "permata", "va_number": "1234567890"},
      "transaction_details": {
        "order_id": "order-101b-{{2019-11-012222123123123}}",
        "gross_amount": 44000
      },
      "customer_details": {
        "email": "richie@example.com",
        "first_name": "Richie",
        "last_name": "Permana",
        "phone": "+6281 1234 1234"
      },
      "item_details": [
        {
          "id": "item01",
          "price": 21000,
          "quantity": 1,
          "name": "Schema Programmer"
        },
        {"id": "item02", "price": 23000, "quantity": 1, "name": "Ayam Xoxoxo"}
      ]
    });
    final Map<String, String> header = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization':
          'Basic U0ItTWlkLXNlcnZlci0ySy1VMU1CMmNJbzFQa2NLc2ptamlHcUU6',
      'cache-control': 'no-cache'
    };
    Map datas = {
      'data': {
        "payment_type": "bank_transfer",
        "bank_transfer": {"bank": "permata", "va_number": "1234567890"},
        "transaction_details": {
          "order_id": "order-101b-{{2019-11-04mm}}",
          "gross_amount": 44000
        },
        "customer_details": {
          "email": "richie@example.com",
          "first_name": "Richie",
          "last_name": "Permana",
          "phone": "+6281 1234 1234"
        },
        "item_details": [
          {
            "id": "item01",
            "price": 21000,
            "quantity": 1,
            "name": "Schema Programmer"
          },
          {"id": "item02", "price": 23000, "quantity": 1, "name": "Ayam Xoxoxo"}
        ]
      }
    };

    // HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    // request.headers.clear();
    // request.headers.set('Authorization',
    //     'Basic U0ItTWlkLXNlcnZlci0ySy1VMU1CMmNJbzFQa2NLc2ptamlHcUU6');
    // request.headers.set('Accept', 'application/json');
    // request.headers.set('Content-Type', 'application/json');
    // print(request.headers);
    // request.add(utf8.encode(jsonEncode(datas)));
    // HttpClientResponse response = await request.close();
    // String reply = await response.transform(utf8.decoder).join();
    // httpClient.close();

    // print("ngeheeee midtrans zzz => $reply");

    // return reply;

    Response response = await http.post(
      url,
      headers: header,
      body: json,
    );

    var res = jsonDecode(response.body);
    print("payloadddded =>> ${json}\n");
    if (res['status_code'] == 201) {
      print("ngeheeeee berhasil MIDTRAANSS =>> ${res['status_code']}");
    } else {
      print(
          "ape kaden => ${res['status_code']} || terosz => ${jsonDecode(response.body)}");
    }
  }

  Future<Widget> buildShopCart(
    StateSetter setModalState,
    Certification certification,
  ) async {
    List cart = await prefs.readCart("cart");
    List<String> cartKey = [];

    for (var item in cart) {
      cartKey.add(item.keys.first.toString());
    }
    // print("heeyyoooo length => ${cart.length}\nheeyyoooo isinyaaaa => $cart\n");
    cart.map((val) => print('kle ci nyusahin cart ni => $val'));

    return cart.length > 0
        ? ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, id) {
              return Dismissible(
                onDismissed: (direction) {
                  setModalState(() {
                    prefs.deleteCart(id);
                  });
                },
                direction: DismissDirection.endToStart,
                key: ValueKey(cart[id][cartKey[id]]['name']),
                background: Container(
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: CachedNetworkImage(
                    imageUrl: cart[id][cartKey[id]]['image'],
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
                  title: Text(cart[id][cartKey[id]]['name']),
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder(
                        future: prefs.readCart('cart'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
                              amount: double.parse(
                                  snapshot.data[id][cartKey[id]]['price']),
                              settings: MoneyFormatterSettings(
                                symbol: "IDR",
                                thousandSeparator: ".",
                                decimalSeparator: ",",
                                symbolAndNumberSeparator: " ",
                              ),
                            );

                            return Text(
                              "Rp. ${fmf.output.nonSymbol}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      Text("Sistem Informasi"),
                    ],
                  ),
                  trailing: Container(
                    width: 105,
                    child: Row(
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 15,
                          height: 10,
                          child: RaisedButton(
                            onPressed: () {
                              print("terpencet decreased ${cartKey[id]}");
                              if (cart[id][cartKey[id]]['qty'] <= 1) {
                                return;
                              }
                              setModalState(() {
                                prefs.decreaseCart("cart", cartKey[id]);
                              });
                            },
                            highlightColor: Colors.transparent,
                            elevation: 0,
                            color: Color(0xffe2defc),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "-",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          cart[id][cartKey[id]]['qty'].toString(),
                        ),
                        ButtonTheme(
                          minWidth: 15,
                          height: 10,
                          child: RaisedButton(
                            onPressed: () {
                              print("terpencet increased ${cartKey[id]}");
                              setModalState(() {
                                prefs.addCart("cart", cartKey[id]);
                              });
                            },
                            highlightColor: Colors.transparent,
                            elevation: 0,
                            color: Color(0xffe2defc),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You have no items. Let's buy something! "),
              Icon(Icons.timelapse)
            ],
          );
  }
}
