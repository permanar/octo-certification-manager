import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:sweetalert/sweetalert.dart';

class PayNow extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const PayNow({
    Key key,
    this.formKey,
  }) : super(key: key);

  @override
  _PayNowState createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  bool process = false;

  @override
  Widget build(BuildContext context) {
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
                process = !process;
              });
              validateInput(context, process);
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: process
                          ? SpinKitPulse(color: Color(0xffffffff))
                          : Text(
                              'Pay Now',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            color: Color(0xff5E4FD1),
          ),
        ),
      ),
    );
  }

  validateInput(context, bool process) async {
    if (widget.formKey.currentState.validate()) {
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Processing Data')));

      SweetAlert.show(
        context,
        title: "Payment is Processing",
        subtitle: "Please wait!",
        style: SweetAlertStyle.loading,
      );

      await Future.delayed(Duration(seconds: 3));
      bool res = await _makePayment();
      if (res) {
        SweetAlert.show(
          context,
          title: "Payment Complete",
          subtitle:
              "Your payment is complete!\nWill automatically redirected in a few seconds!",
          style: SweetAlertStyle.success,
        );
      } else {
        SweetAlert.show(
          context,
          title: "Payment Error",
          subtitle:
              "There's something wrong.\nHave you checked everything was okay?",
          style: SweetAlertStyle.error,
        );
      }

      setState(() {
        this.process = !process;
      });
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Successfully ordered!')));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Please complete your payment information first!')));
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        this.process = !process;
      });
    }
  }

  Future<bool> _makePayment() async {
    // HttpClient httpClient = new HttpClient();
    String url = "https://api.sandbox.midtrans.com/v2/charge";

    final Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Basic U0ItTWlkLXNlcnZlci1kNnJNbGp5ZDBKSDgyOEhBT28tSWkxM0E=',
      'cache-control': 'no-cache'
    };

    final Map<String, dynamic> body = {
      "payment_type": "bank_transfer",
      "bank_transfer": {"bank": "permata", "va_number": "1234567890"},
      "transaction_details": {
        "order_id": "order-101b-${Random().nextDouble()}",
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
    };

    var json = jsonEncode(body);

    Response response = await post(
      url,
      headers: header,
      body: utf8.encode(json),
    );

    // var body = jsonEncode({"userid": 123, "login_type": 5788});

    var res = jsonDecode(response.body);
    // print("payloadddded =>> ${json.runtimeType} ||| ${json}\n");
    if (int.parse(res['status_code']) == 201) {
      // print("ngeheeeee berhasil MIDTRAANSS =>> ${res['status_code']}");
      return Future.value(true);
    } else {
      // print("res full =>> ${response.body}");
      // print("ape kaden => ${res['status_code']} || terosz => $res");
      // print(
      //     "ngeheeeee berhasil MIDTRAANSS TAPI INI ELSE =>> ${res['status_code'].runtimeType}");
      return Future.value(false);
    }
  }
}
