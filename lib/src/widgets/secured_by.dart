import 'package:flutter/material.dart';

class SecuredBy extends StatelessWidget {
  const SecuredBy({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> securedBy = [
      "assets/images/payments/secured-amex-safekey.png",
      "assets/images/payments/secured-jcb.png",
      "assets/images/payments/secured-mastercard.png",
      "assets/images/payments/secured-norton.png",
      "assets/images/payments/secured-visa.png",
    ];
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFFe8e8e8),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: securedBy.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, id) {
            return Center(
              child: Container(
                width: 65,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    securedBy[id],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
