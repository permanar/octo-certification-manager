import 'package:bisma_certification/src/pages/detail_page.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/widgets/certifications_carousel.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bisma Certification",
          style: TextStyle(
            color: Colors.red[300],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider<CertificationBloc>(
        create: (context) => CertificationBloc(
            certificationRepository: FirebaseCertificationRepository())
          ..add(LoadAll()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              child: Column(
                // overflow: Overflow.visible,
                children: [
                  Container(
                    height: 150,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new Image.network(
                          "http://via.placeholder.com/350x150",
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: 5,
                      viewportFraction: 0.8,
                      pagination: SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: SwiperPagination.dots,
                      ),
                      control: SwiperControl(
                        iconNext: Icons.navigate_next,
                        iconPrevious: Icons.navigate_before,
                      ),

                      scale: 0.9,
                      autoplay: true,
                      // duration: 3000,
                      fade: .2,
                      loop: false,
                      curve: Curves.ease,
                      // layout: SwiperLayout.STACK,
                      itemWidth: 300,
                      itemHeight: 150,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ),
                            BlocBuilder<CertificationBloc, CertificationState>(
                              builder: (context, state) =>
                                  CertificationCarousel(
                                context: context,
                                certificationBloc:
                                    BlocProvider.of<CertificationBloc>(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("data"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
