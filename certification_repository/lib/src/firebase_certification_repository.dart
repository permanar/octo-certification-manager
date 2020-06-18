import 'package:certification_repository/certification_repository.dart';
import 'package:certification_repository/src/entities/schedules_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'entities/entities.dart';

class FirebaseCertificationRepository implements CertificationRepository {
  final certificationCollection = Firestore.instance;

  @override
  Stream<List<Certification>> getAll() {
    return certificationCollection
        .collection("certifications")
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((snap) {
        return Certification.fromEntity(CertificationEntity.fromSnapshot(snap));
      }).toList();
    });
  }

  @override
  Stream<Certification> getDetail(String document) {
    return certificationCollection
        .collection("certifications")
        .document(document)
        .snapshots()
        .map((snapshot) {
      return Certification.fromEntity(
          CertificationEntity.fromSnapshot(snapshot));
    });
  }

  @override
  Stream<List<Schedules>> getScheduleDetail(int nim) {
    return certificationCollection
        .collection("schedules")
        .where("id_collegers", arrayContains: nim)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((snap) {
        return Schedules.fromEntity(SchedulesEntity.fromSnapshot(snap));
      }).toList();
    });
  }
}
