import 'package:intl/intl.dart';
import 'package:certification_repository/certification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bisma_certification/src/bloc/bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyClass extends StatefulWidget {
  MyClass({Key key}) : super(key: key);

  @override
  _MyClassState createState() => _MyClassState();
}

class _MyClassState extends State<MyClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Class"),
      ),
      body: BlocProvider<CertificationBloc>(
        create: (context) => CertificationBloc(
            certificationRepository: FirebaseCertificationRepository())
          ..add(LoadSchedules(160030268)),
        child: Container(
          child: BlocBuilder<CertificationBloc, CertificationState>(
            builder: (context, state) {
              if (state is SchedulesReady) {
                final schedules = state.schedule;

                return ListView.builder(
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    final _dateTime =
                        DateFormat('yyyy-MM-dd HH:mm').parse(schedule.datetime);
                    return ListTile(
                      leading: Icon(Icons.beenhere, ),
                      title: Text(schedule.id),
                      subtitle: Text("On: $_dateTime"),
                      trailing: Container(
                        height: double.infinity,
                        width: 75,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            "OPEN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is Loading) {
                print("ini masuk ke state loading");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitPulse(color: Color(0xff0E4E95)),
                    SizedBox(height: 20),
                    Text("Getting Your Schedules Information Ready"),
                  ],
                );
              } else {
                return Center(
                  child: Text("No class currently active!"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
