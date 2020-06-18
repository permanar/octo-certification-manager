import 'package:bisma_certification/src/pages/checkout_page.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BottomSheetCart extends StatefulWidget {
  final Color color;

  BottomSheetCart({Key key, this.color = Colors.white}) : super(key: key);

  @override
  _BottomSheetCartState createState() => _BottomSheetCartState();
}

class _BottomSheetCartState extends State<BottomSheetCart> {
  SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

    return Container(
      child: GestureDetector(
        onTap: () {
          bottomSheetCart(context);
        },
        child: Icon(
          Icons.shopping_cart,
          color: color,
        ),
      ),
    );
  }

  bottomSheetCart(BuildContext context) async {
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
                            future: buildShopCart(setModalState),
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
                                          page: CheckoutPage(),
                                        ),
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

  Future<Widget> buildShopCart(
    StateSetter setModalState,
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
