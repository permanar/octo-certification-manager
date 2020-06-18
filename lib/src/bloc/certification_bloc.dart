import 'dart:async';
import 'package:certification_repository/certification_repository.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import './bloc.dart';

class CertificationBloc extends Bloc<CertificationEvent, CertificationState> {
  final CertificationRepository _certificationRepository;
  StreamSubscription _certificationSubscription;
  StreamSubscription _scheduleSubscription;

  CertificationBloc({@required CertificationRepository certificationRepository})
      : assert(certificationRepository != null),
        _certificationRepository = certificationRepository;

  @override
  CertificationState get initialState => Loading();

  @override
  Stream<CertificationState> mapEventToState(
    CertificationEvent event,
  ) async* {
    if (event is LoadAll) {
      yield* _mapLoadAllToState(event);
    }
    if (event is LoadAllFinished) {
      yield* _mapLoadAllFinishedToState(event);
    }
    if (event is LoadSchedules) {
      yield* _mapLoadSchedulesToState(event);
    }
    if (event is LoadSchedulesFinished) {
      yield* _mapLoadSchedulesFinishedToState(event);
    }
  }

  Stream<CertificationState> _mapLoadAllToState(LoadAll event) async* {
    _certificationSubscription?.cancel();
    _certificationSubscription =
        _certificationRepository.getAll().listen((val) {
      add(LoadAllFinished(val));
    });
  }

  Stream<CertificationState> _mapLoadAllFinishedToState(
      LoadAllFinished event) async* {
    yield Ready(event.certification);
  }

  Stream<CertificationState> _mapLoadSchedulesToState(
      LoadSchedules event) async* {
    print("ini masuk ke state boskuh");

    _scheduleSubscription?.cancel();
    _scheduleSubscription =
        _certificationRepository.getScheduleDetail(event.nim).listen((val) {
      add(LoadSchedulesFinished(val));
    });
  }

  Stream<CertificationState> _mapLoadSchedulesFinishedToState(
      LoadSchedulesFinished event) async* {
    yield SchedulesReady(event.schedule);
  }

  @override
  Future<void> close() {
    _certificationSubscription?.cancel();
    _scheduleSubscription?.cancel();
    return super.close();
  }
}
