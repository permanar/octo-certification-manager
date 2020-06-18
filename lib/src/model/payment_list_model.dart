import 'package:bisma_certification/src/pages/payment/payment_detail.dart';
import 'package:flutter/material.dart';

class PaymentList {
  final String image;
  final String title;
  final String subtitle;
  final Widget page;

  PaymentList({
    this.image,
    this.title,
    this.subtitle,
    this.page,
  });
}

class ListBank {
  final String name;
  final String desc;
  final String image;
  final Widget page;

  ListBank({
    this.name,
    this.desc,
    this.image,
    this.page,
  });
}

// Manually inserting the data
List<PaymentList> paymentsList = [
  PaymentList(
    title: 'Credit/Debit Card',
    subtitle: 'Pay with VISA, MasterCard, JCB or AMEX',
    image: 'assets/images/payments/cc.png',
    page: PaymentDetailCC(),
  ),
  PaymentList(
    title: 'ATM/Bank Transfer',
    subtitle: 'Pay from ATM bersama, Prima, or Alto',
    image: 'assets/images/payments/bank-transfer.png',
    page: PaymentDetailATM(
      listBank: [
        ListBank(
          name: "BCA",
          desc: 'Pay from BCA ATMs or Internet Banking',
          image: 'assets/images/payments/klikbca.png',
          page: PaymentDetailCC(),
        ),
        ListBank(
          name: "Mandiri",
          desc: 'Pay from BCA ATMs or Internet Banking',
          image: 'assets/images/payments/klikbca.png',
          page: PaymentDetailCC(),
        ),
        ListBank(
          name: "Permata",
          desc: 'Pay from BCA ATMs or Internet Banking',
          image: 'assets/images/payments/klikbca.png',
          page: PaymentDetailCC(),
        ),
        ListBank(
          name: "BNI",
          desc: 'Pay from BCA ATMs or Internet Banking',
          image: 'assets/images/payments/klikbca.png',
          page: PaymentDetailCC(),
        ),
        ListBank(
          name: "Other ATMs Network",
          desc: 'Pay from BCA ATMs or Internet Banking',
          image: 'assets/images/payments/klikbca.png',
          page: PaymentDetailCC(),
        ),
      ],
    ),
  ),
  PaymentList(
    title: 'GoPay',
    subtitle: 'Pay with your GoPay wallet',
    image: 'assets/images/payments/gopay.png',
    page: PaymentDetailGopay(),
  ),
  PaymentList(
    title: 'KlikBCA',
    subtitle: 'Pay with your KlikBCA account',
    image: 'assets/images/payments/klikbca.png',
    page: PaymentDetailKlikBCA(),
  ),
  PaymentList(
    title: 'Indomaret',
    subtitle: 'Pay from Indomaret convenience stores',
    image: 'assets/images/payments/indomaret.png',
    page: PaymentDetailIndomaret(),
  ),
];
