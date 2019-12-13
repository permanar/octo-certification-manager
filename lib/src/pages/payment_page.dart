import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  SharedPrefs prefs = SharedPrefs();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future isLoad() async {
    await Future.delayed(Duration(seconds: 3));
    return _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // bottomNavigationBar: bottomNavDetailPage(context),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black45,
        ),
        title: Text(
          "Choose Payment",
          style: TextStyle(color: Colors.black45),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: isLoad(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitPulse(color: Color(0xff0E4E95)),
                    SizedBox(height: 20),
                    Text("Loading Payment List"),
                  ],
                ),
              );
            } else {
              return SmartRefresher(
                controller: _refreshController,
                header: WaterDropHeader(),
                enablePullUp: true,
                enablePullDown: true,
                onRefresh: isLoad,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: <Widget>[
                      StickyHeader(
                        header: DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          child: Container(
                            color: Color(0xff0E4E95),
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Total Amount"),
                                      FutureBuilder(
                                        future: prefs.readCart('cart'),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            int total = 0;

                                            for (var item in snapshot.data) {
                                              print(item);
                                              total += int.parse(
                                                  item[item.keys.first]
                                                      ['total']);
                                            }

                                            FlutterMoneyFormatter fmf =
                                                FlutterMoneyFormatter(
                                              amount: double.parse(
                                                  total.toString()),
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
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Order ID",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        "157912318738",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text("data"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
