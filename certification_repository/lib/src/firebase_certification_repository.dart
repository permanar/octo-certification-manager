import 'package:certification_repository/certification_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'entities/entities.dart';

class FirebaseCertificationRepository implements CertificationRepository {
  final ceritificationCollection =
      Firestore.instance.collection("certifications");

  @override
  Stream<List<Certification>> getAll() {
    return ceritificationCollection.snapshots().map((snapshot) {
      return snapshot.documents.map((snap) {
        return Certification.fromEntity(CertificationEntity.fromSnapshot(snap));
      }).toList();
    });
  }

  @override
  Stream<Certification> getDetail(String document) {
    return ceritificationCollection
        .document(document)
        .snapshots()
        .map((snapshot) {
      return Certification.fromEntity(
          CertificationEntity.fromSnapshot(snapshot));
    });
  }
}
