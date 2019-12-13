import 'package:certification_repository/certification_repository.dart';
import 'package:equatable/equatable.dart';

abstract class CertificationState extends Equatable {
  const CertificationState();

  @override
  List<Object> get props => [];
}

class Ready extends CertificationState {
  final List<Certification> certification;

  Ready([this.certification]);

  @override
  List<Object> get props => [certification];

  @override
  String toString() => "CertificationReady { certification: $certification }";
}

class Loading extends CertificationState {}
