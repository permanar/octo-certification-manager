import 'dart:async';
import 'package:certification_repository/certification_repository.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import './bloc.dart';

class CertificationBloc extends Bloc<CertificationEvent, CertificationState> {
  final CertificationRepository _certificationRepository;
  StreamSubscription _certificationsubscription;

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
  }

  Stream<CertificationState> _mapLoadAllToState(LoadAll event) async* {
    _certificationsubscription?.cancel();
    _certificationsubscription =
        _certificationRepository.getAll().listen((val) {
      add(LoadAllFinished(val));
    });
  }

  Stream<CertificationState> _mapLoadAllFinishedToState(
      LoadAllFinished event) async* {
    yield Ready(event.certification);
  }

  @override
  Future<void> close() {
    _certificationsubscription?.cancel();
    return super.close();
  }
}
