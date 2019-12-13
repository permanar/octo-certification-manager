import 'package:certification_repository/certification_repository.dart';
import 'package:equatable/equatable.dart';

abstract class CertificationEvent extends Equatable {
  const CertificationEvent();

  @override
  List<Object> get props => [];
}

class LoadAll extends CertificationEvent {}

class LoadAllFinished extends CertificationEvent {
  final List<Certification> certification;

  LoadAllFinished(this.certification);

  @override
  List<Object> get props => [certification];
}
