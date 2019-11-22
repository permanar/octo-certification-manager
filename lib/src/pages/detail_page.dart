import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:bisma_certification/src/pages/checkout_page.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:curl/curl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;

import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:bisma_certification/src/widgets/custom_shape_clipper.dart';
import 'package:http/http.dart';

class DetailPage extends StatefulWidget {
  final List<int> todos;

  const DetailPage({Key key, this.todos}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  SharedPrefs prefs = SharedPrefs();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  IconData favs = Icons.favorite_border;
  bool showBottomSheet = false, favsBool = false;
  Set<String> unselectableDates;

  sanitizeDateTime(DateTime dateTime) =>
      "${dateTime.year}-${dateTime.month}-${dateTime.day}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: bottomNavDetailPage(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
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
                      imageUrl:
                          "https://cdn.dribbble.com/users/1724007/screenshots/6652697/attachments/1421572/thumbnail/product_screen.png",
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
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
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
                            bottomSheetCart(context);
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
                                "Skema Programmer",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Container(
                                transform: Matrix4.translationValues(0, -30, 0),
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
                              width: MediaQuery.of(context).size.width * .85,
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
                              width: MediaQuery.of(context).size.width * .85,
                              child: GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2018),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(2021),
                                    // selectableDayPredicate: (DateTime val) {
                                    //   String sanitized = sanitizeDateTime(val);
                                    //   return !unselectableDates
                                    //       .contains(sanitized);
                                    // },
                                    // selectableDayPredicate: (DateTime val) =>
                                    //     val.weekday == 5 || val.weekday == 6
                                    //         ? false
                                    //         : true,
                                  ).then((val) => print(
                                      DateTime(val.year, val.month, val.day)));
                                },
                                child: Text(
                                  "Pogrammer atau Pemrogram Aplikasi (KBJI: 2514.00; ISCO: 2514) memiliki tanggung jawab dalam menulis dan memelihara kode pemrograman yang diuraikan dalam instruksi dan spesifikasi teknis untuk aplikasi perangkat lunak dan sistem operasi. Skema Programmer bertujuan untuk digunakan sebagai acuan dalam kegiatan sertifikasi kompetensi jabatan kerja Programmer. Skema mengacu pada Standar Kompetensi Kerja Nasional Indonesia (SKKNI) Kategori Informasi dan Komunikasi Golongan Pokok Aktivitas Pemrograman, Konsultasi Komputer dan Kegiatan YBDI Bidang Software Development Subbidang Pemrograman Nomor 282 Tahun 2016 tanggal 8 November 2016.",
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
                  StreamBuilder(
                    stream: Firestore.instance
                        .collection("users")
                        .orderBy("username", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text('Loading...');
                      Future.delayed(Duration(seconds: 2));
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int id) {
                          return ListTile(
                            title: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                          "$id => ${snapshot.data.documents[id]['username']}"),
                                    ),
                                    Expanded(
                                      child: Text(
                                          "${snapshot.data.documents[id]['pass']}"),
                                    ),
                                  ],
                                ),
                                // _test(id),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget bottomNavDetailPage(context) {
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
                    prefs.addCart("cart", [
                      'https://cdn.dribbble.com/users/2066845/screenshots/7057706/media/fb081170a9d922edb7628ac4f43e066d.png',
                      "Schema Programmer",
                      "450.000"
                    ]);
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

  bottomSheetCart(BuildContext context) async {
    var carts = await prefs.readCart("cart");

    double total = 0;
    for (var i = 0; i < carts.length; i++) {
      for (var j = 0; j < carts[i].length; j++) {
        total += (j == 2) ? int.parse(carts[i][j].replaceAll(".", "")) : 0;
      }
    }

    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: total,
      settings: MoneyFormatterSettings(
        symbol: "IDR",
        thousandSeparator: ".",
        decimalSeparator: ",",
        symbolAndNumberSeparator: " ",
      ),
    );

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (BuildContext bc) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                Divider(),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Subtotal:"),
                          Text("Rp. ${fmf.output.nonSymbol}"),
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
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: FlatButton(
                          onPressed: () {
                            _makePayment();
                            // setState(() {
                            //   Navigator.of(context).push(
                            //     PageTransitionSlideLeft(page: CheckoutPage()),
                            //   );
                            // });
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
        );
      },
    );
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
                  leading: CachedNetworkImage(
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
                  title: Text(cart[id][1]),
                  subtitle: Text("Rp. ${cart[id][2]}"),
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
}
