import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:equatable/equatable.dart';

abstract class CreditCardState extends Equatable {
  const CreditCardState();

  @override
  List<Object> get props => [];
}

class ReadyCreditCard extends CreditCardState {
  final CreditCardType ccType;
  final String errMsg;

  ReadyCreditCard(this.ccType, this.errMsg);

  @override
  List<Object> get props => [ccType];
}

class FinishedCreditCard extends CreditCardState {
  final CreditCardType ccType;

  FinishedCreditCard(this.ccType);

  @override
  List<Object> get props => [ccType];
}
