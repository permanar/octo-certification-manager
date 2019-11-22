import 'package:bisma_certification/src/pages/profile_page.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  SharedPrefs prefs = SharedPrefs();

  Future<Widget> buildShopCart() async {
    List cart = await prefs.readCart("cart");
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
                key: ValueKey(cart[id][1]),
                background: Container(
                  color: Colors.grey[200],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: cart[id][0],
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
                  title: Text(cart[id][1]),
                  subtitle: Row(
                    children: <Widget>[
                      Text("Quantity: 1"),
                      SizedBox(width: 20),
                      Text("Rp. ${cart[id][2]}")
                    ],
                  ),
                  trailing: Icon(Icons.close),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 255,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
