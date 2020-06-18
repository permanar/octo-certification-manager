import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:bisma_certification/src/pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiscoverCarousel extends StatelessWidget {
  final Certification certification;
  final CertificationBloc certificationBloc;
  final BuildContext context;

  const DiscoverCarousel(
      {Key key, this.certificationBloc, this.context, this.certification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);

    return BlocBuilder<CertificationBloc, CertificationState>(
      builder: (context, state) {
        if (state is Ready) {
          final certifications = state.certification;
          final discoverItemSlider = CarouselSlider(
            height: 150.0,
            viewportFraction: 1.0,
            items: certifications.map(
              (certification) {
                FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
                  amount: double.parse(certification.price),
                  settings: MoneyFormatterSettings(
                    symbol: "IDR",
                    thousandSeparator: ".",
                    decimalSeparator: ",",
                    symbolAndNumberSeparator: " ",
                  ),
                );

                return Builder(
                  builder: (BuildContext context) {
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: device.size.width * .35,
                            height: device.size.height * .90,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image(
                                    height: device.size.height,
                                    image: CachedNetworkImageProvider(
                                      certification.image,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                AutoSizeText(
                                  certification.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  "Rp. ${fmf.output.nonSymbol}",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                FlatButton.icon(
                                  shape: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => DetailPage(
                                          certification: certification,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.date_range),
                                  label: Text(
                                    "Read More",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Discover",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        radius: 50,
                        onTap: () => discoverItemSlider.previousPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeOutBack),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(Icons.arrow_back_ios, size: 15),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () => discoverItemSlider.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.easeOutBack),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Icon(Icons.arrow_forward_ios, size: 15),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: discoverItemSlider,
              ),
            ],
          );
        } else if (state is Loading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitPulse(color: Color(0xff0E4E95)),
              SizedBox(height: 20),
              Text("Getting List of Certifications"),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
