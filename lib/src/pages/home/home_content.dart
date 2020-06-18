import 'package:auto_size_text/auto_size_text.dart';
import 'package:bisma_certification/src/pages/detail_page.dart';
import 'package:bisma_certification/src/utils/bottom_sheet.dart';
import 'package:bisma_certification/src/utils/page_transition.dart';
import 'package:bisma_certification/src/widgets/certifications_carousel.dart';
import 'package:bisma_certification/src/widgets/discover_carousel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bisma Certification",
          style: TextStyle(
            color: Colors.blue[300],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: BottomSheetCart(color: Colors.blue),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider<CertificationBloc>(
        create: (context) => CertificationBloc(
            certificationRepository: FirebaseCertificationRepository())
          ..add(LoadAll()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 100),
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
                  BlocBuilder<CertificationBloc, CertificationState>(
                    builder: (context, state) => CertificationCarousel(
                      context: context,
                      certificationBloc:
                          BlocProvider.of<CertificationBloc>(context),
                    ),
                  ),
                  BlocBuilder<CertificationBloc, CertificationState>(
                    builder: (context, state) => DiscoverCarousel(
                      context: context,
                      certificationBloc:
                          BlocProvider.of<CertificationBloc>(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
