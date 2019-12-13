import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/pages/payment_page.dart';
import 'package:bisma_certification/src/pages/profile_page.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  SharedPrefs prefs = SharedPrefs();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: bottomNavDetailPage(context),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black45,
        ),
        title: Text(
          "Checkout",
          style: TextStyle(color: Colors.black45),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 150,
                      maxHeight: 250,
                    ),
                    child: FutureBuilder(
                      initialData: CircularProgressIndicator(),
                      future: buildShopCart(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data;
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Recipient Name",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).push(
                                  PageTransitionSlideLeft(page: ProfilePage()),
                                );
                              });
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Color(0xff1d4f6a),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Richie Permana",
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Address",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).push(
                                  PageTransitionSlideLeft(
                                      page: ProfilePage(
                                    currentPage: 2,
                                  )),
                                );
                              });
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                color: Color(0xff1d4f6a),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .4,
                          child: Text(
                            "Jln Kebo Iwa Utara Gang Danau Tawar II No. 3x",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Subtotal"),
                          FutureBuilder(
                            future: prefs.readCart('cart'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int total = 0;

                                for (var item in snapshot.data) {
                                  print(item);
                                  total +=
                                      int.parse(item[item.keys.first]['total']);
                                }

                                FlutterMoneyFormatter fmf =
                                    FlutterMoneyFormatter(
                                  amount: double.parse(total.toString()),
                                  settings: MoneyFormatterSettings(
                                    symbol: "IDR",
                                    thousandSeparator: ".",
                                    decimalSeparator: ",",
                                    symbolAndNumberSeparator: " ",
                                  ),
                                );

                                return Text("Rp. ${fmf.output.nonSymbol}");
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Discount"),
                          Text("-"),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          FutureBuilder(
                            future: prefs.readCart('cart'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int total = 0;

                                for (var item in snapshot.data) {
                                  print(item);
                                  total +=
                                      int.parse(item[item.keys.first]['total']);
                                }

                                FlutterMoneyFormatter fmf =
                                    FlutterMoneyFormatter(
                                  amount: double.parse(total.toString()),
                                  settings: MoneyFormatterSettings(
                                    symbol: "IDR",
                                    thousandSeparator: ".",
                                    decimalSeparator: ",",
                                    symbolAndNumberSeparator: " ",
                                  ),
                                );

                                return Text("Rp. ${fmf.output.nonSymbol}");
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> buildShopCart() async {
    List cart = await prefs.readCart("cart");
    List<String> cartKey = [];

    for (var item in cart) {
      cartKey.add(item.keys.first.toString());
    }
    // print("heeyyoooo length => ${cart.length}\nheeyyoooo isinyaaaa => $cart\n");

    return cart.length > 0
        ? ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, id) {
              return Dismissible(
                onDismissed: (direction) {
                  setState(() {
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
                  title: AutoSizeText(
                    cart[id][cartKey[id]]['name'],
                    maxLines: 2,
                  ),
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

                            return AutoSizeText(
                              "Rp. ${fmf.output.nonSymbol}",
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      AutoSizeText(
                        "Sistem Informasi",
                        maxLines: 1,
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 113,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 15,
                          height: 10,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                if (cart[id][cartKey[id]]['qty'] <= 1) {
                                  return;
                                }
                                prefs.decreaseCart("cart", "LSPP");
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
                              setState(() {
                                prefs.addCart("cart", "LSPP");
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

  Widget bottomNavDetailPage(context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FlatButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).push(
                  PageTransitionFade(page: PaymentPage()),
                );
              });
            },
            child: Text(
              'Pay',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Color(0xff5E4FD1),
          ),
        ),
      ),
    );
  }
}
