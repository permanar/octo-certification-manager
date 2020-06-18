import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:bisma_certification/src/utils/shared_prefs.dart';
import 'package:bisma_certification/src/widgets/button_pay_now.dart';
import 'package:bisma_certification/src/widgets/credit_card_form.dart';
import 'package:bisma_certification/src/widgets/secured_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PaymentDetailCC extends StatefulWidget {
  @override
  _PaymentDetailCCState createState() => _PaymentDetailCCState();
}

class _PaymentDetailCCState extends State<PaymentDetailCC> {
  SharedPrefs prefs = SharedPrefs();
  bool firstLoad = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F5F7),
        elevation: 1,
        leading: BackButton(
          color: Colors.black45,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Octo Certification Payment",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "Pay with Credit Card ",
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
      body: BlocProvider<CreditCardBloc>(
        create: (context) => CreditCardBloc(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: <Widget>[
                BlocBuilder<CreditCardBloc, CreditCardState>(
                  builder: (context, state) => CreditCardForm(
                    formKey: _formKey,
                    context: context,
                    creditCardBloc: BlocProvider.of<CreditCardBloc>(context),
                  ),
                ),
                Divider(),
                Expanded(child: Container()),
                SecuredBy(),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                PayNow(formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
