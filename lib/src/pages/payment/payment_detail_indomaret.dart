import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/model/payment_list_model.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

class PaymentDetailIndomaret extends StatefulWidget {
  @override
  _PaymentDetailIndomaretState createState() => _PaymentDetailIndomaretState();
}

class _PaymentDetailIndomaretState extends State<PaymentDetailIndomaret> {
  SharedPrefs prefs = SharedPrefs();
  bool firstLoad = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
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
          "Pay with Credit Card ",
          style: TextStyle(color: Colors.black45),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            StickyHeader(
              header: DefaultTextStyle(
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                child: Container(
                  color: Color(0xff0E4E95),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        item[item.keys.first]['total']);
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              content: Container(
                margin: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  itemCount: paymentsList.length,
                  separatorBuilder: (context, id) => Divider(),
                  itemBuilder: (context, id) {
                    var paymentList = paymentsList[id];

                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                  paymentList.image,
                                ),
                              ),
                            ),
                          ),
                          title: Text(paymentList.title),
                          subtitle: Text(paymentList.subtitle),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
