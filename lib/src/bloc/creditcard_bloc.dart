import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import './bloc.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  StreamController _creditCardSubscription;

  @override
  CreditCardState get initialState =>
      ReadyCreditCard(CreditCardType.unknown, null);

  @override
  Stream<CreditCardState> mapEventToState(
    CreditCardEvent event,
  ) async* {
    if (event is CheckingCreditCard) {
      yield* _buildCreditCardLogo(event);
    }
  }

  Stream<CreditCardState> _buildCreditCardLogo(
      CheckingCreditCard event) async* {
    var res = detectCCType(event.cc);
    bool validate = false;
    String errMsg;
    print("validate 1 ==> $validate");

    CreditCardType.values.forEach((f) {
      if ((res.toString() == f.toString() && f.index == 0) ||
          (res.toString() == f.toString() && f.index == 1) ||
          (res.toString() == f.toString() && f.index == 3) ||
          (res.toString() == f.toString() && f.index == 5)) {
        validate = true;
      }
    });

    errMsg = validate ? null : 'Enter the valid Credit Card number!';

    yield ReadyCreditCard(res, errMsg);
  }

  @override
  Future<void> close() {
    // _creditCardSubscription?.cancel();
    return super.close();
  }
}
