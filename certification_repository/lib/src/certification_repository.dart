import 'dart:async';

import 'package:certification_repository/certification_repository.dart';

abstract class CertificationRepository {
  Stream<List<Certification>> getAll();

  Stream<Certification> getDetail(String document);
}
