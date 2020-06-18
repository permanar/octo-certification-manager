import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:bisma_certification/src/pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:bisma_certification/src/models/certification_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CertificationCarousel extends StatelessWidget {
  final Certification certification;
  final CertificationBloc certificationBloc;
  final BuildContext context;

  const CertificationCarousel(
      {Key key, this.certification, this.context, this.certificationBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CertificationBloc, CertificationState>(
      builder: (context, state) {
        if (state is Ready) {
          final certifications = state.certification;

          return Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Most Picked Certifications',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('See All'),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: certifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final certification = certifications[index];

                    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
                      amount: double.parse(certification.price),
                      settings: MoneyFormatterSettings(
                        symbol: "IDR",
                        thousandSeparator: ".",
                        decimalSeparator: ",",
                        symbolAndNumberSeparator: " ",
                      ),
                    );

                    return GestureDetector(
                      onTap: () {
                        // certificationBloc.add(LoadDetail());
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => DetailPage(
                              certification: certification,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 210.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              bottom: 15.0,
                              child: Container(
                                height: 120.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        certification.name,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      AutoSizeText(
                                        certification.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: certification.id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image(
                                        height: 180.0,
                                        width: 180.0,
                                        image: CachedNetworkImageProvider(
                                          certification.image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        AutoSizeText(
                                          certification.name,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons
                                                      .locationArrow,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 5.0),
                                                Text(
                                                  certification.id,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            AutoSizeText(
                                              "Rp. ${fmf.output.nonSymbol}",
                                              style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
