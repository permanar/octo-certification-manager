import 'package:equatable/equatable.dart';

abstract class CreditCardEvent extends Equatable {
  const CreditCardEvent();

  @override
  List<Object> get props => [];
}

class CheckingCreditCard extends CreditCardEvent {
  final String cc;

  CheckingCreditCard(this.cc);

  @override
  List<Object> get props => [cc];
}
