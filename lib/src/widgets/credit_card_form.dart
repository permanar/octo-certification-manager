import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Supported card types
// enum CreditCardType {
//   visa,
//   amex,
//   mastercard,
//   jcb,
//   unknown,
// }

class CreditCardForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final BuildContext context;
  final CreditCardBloc creditCardBloc;

  const CreditCardForm({
    Key key,
    this.formKey,
    this.context,
    this.creditCardBloc,
  }) : super(key: key);

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final _ccController = new MaskedTextController(mask: '0000 0000 0000 0000');
  final _expController = new MaskedTextController(mask: '00 / 00');
  @override
  Widget build(BuildContext context) {
    // var ccType;

    return Container(
      child: Form(
        key: widget.formKey,
        // autovalidate: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Credit Card Details"),
            BlocBuilder<CreditCardBloc, CreditCardState>(
              builder: (context, state) {
                if (state is ReadyCreditCard) {
                  CreditCardType cc = state.ccType;
                  String errMsg = state.errMsg;
                  print("yeaaaayy errorrr jinggg ---- $errMsg");

                  return TextFormField(
                    controller: _ccController,
                    maxLength: 19,
                    textInputAction: TextInputAction.next,
                    focusNode: f1,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      BlocProvider.of<CreditCardBloc>(context)
                          .add(CheckingCreditCard(v));

                      if (v.length == 19) {
                        f1.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      }
                    },
                    validator: (String val) {
                      print("val --=> $val");
                      if (errMsg != null && val.isEmpty) {
                        return 'Enter the valid Credit Card Number!';
                      } else if (val.length != 19) {
                        return 'Please complete your Credit Card Number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Credit Card Number",
                      hintText: "XXXX XXXX XXXX XXXX",
                      counterText: "",
                      errorStyle: TextStyle(color: Colors.red),
                      errorText: errMsg,
                      suffixIcon: _buildIconCC(cc),
                    ),
                  );
                } else {
                  return Center(
                    child: Expanded(
                      child: Container(
                        child: SpinKitCircle(),
                      ),
                    ),
                  );
                }
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _expController,
                    maxLength: 7,
                    textInputAction: TextInputAction.next,
                    focusNode: f2,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      if (v.length == 7) {
                        f2.unfocus();
                        FocusScope.of(context).requestFocus(f3);
                      } else if (v.length == 0) {
                        f2.unfocus();
                        FocusScope.of(context).requestFocus(f1);
                      }
                    },
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'Enter the valid Credit Card numbersss!';
                      } else if (val.length != 7) {
                        return 'Please complete your Exp. Date';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Expiration Date (MM/YY)",
                      hintText: "01 / 20",
                      counterText: "",
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    maxLength: 6,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    focusNode: f3,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      if (v.length == 0) {
                        f3.unfocus();
                        FocusScope.of(context).requestFocus(f2);
                      } else if (v.length == 6) {
                        f3.unfocus();
                      }
                    },
                    validator: (String val) {
                      if (val.isEmpty) {
                        return 'CVV invalid!';
                      } else if (val.length < 3) {
                        return 'CVV required at least 3 ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "CVV",
                      hintText: "123456",
                      counterText: "",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCC(CreditCardType ccType) {
    Widget icon;
    double ccIconSize = 30.0;
    print("ini build icon jingggg ==========> $ccType");

    switch (ccType) {
      case CreditCardType.visa:
        icon = Icon(
          FontAwesomeIcons.ccVisa,
          size: ccIconSize,
          color: Color(0xff5E4FD1),
        );
        break;

      case CreditCardType.mastercard:
        icon = Icon(
          FontAwesomeIcons.ccMastercard,
          size: ccIconSize,
          color: Color(0xff5E4FD1),
        );
        break;

      case CreditCardType.amex:
        icon = Icon(
          FontAwesomeIcons.ccAmex,
          size: ccIconSize,
          color: Color(0xff5E4FD1),
        );
        break;

      case CreditCardType.jcb:
        icon = Icon(
          FontAwesomeIcons.ccJcb,
          size: ccIconSize,
          color: Color(0xff5E4FD1),
        );
        break;

      default:
        icon = SizedBox.shrink();
        ccType = CreditCardType.unknown;
    }

    return icon;
  }
}
