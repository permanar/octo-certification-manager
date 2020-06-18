import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Schedules {
  final String datetime;
  final String id;
  final String idCertification;
  final List idCollegers;
  final Status status;

  Schedules({
    this.datetime,
    this.id,
    this.idCertification,
    this.idCollegers,
    this.status,
  });

  Schedules copyWith({
    String datetime,
    String id,
    String idCertification,
    List idCollegers,
    Status status,
  }) {
    return Schedules(
      datetime: datetime ?? this.datetime,
      id: id ?? this.id,
      idCertification: idCertification ?? this.idCertification,
      idCollegers: idCollegers ?? this.idCollegers,
      status: status ?? this.status,
    );
  }

  @override
  int get hashCode =>
      datetime.hashCode ^
      id.hashCode ^
      idCertification.hashCode ^
      idCollegers.hashCode ^
      status.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Schedules &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          datetime == other.id &&
          idCertification == other.idCertification &&
          idCollegers == other.idCollegers &&
          status == other.status;

  SchedulesEntity toEntity() {
    return SchedulesEntity(
      datetime: datetime,
      id: id,
      idCertification: idCertification,
      idCollegers: idCollegers,
      status: status,
    );
  }

  static Schedules fromEntity(SchedulesEntity entity) {
    return Schedules(
      datetime: entity.datetime,
      id: entity.id,
      idCertification: entity.idCertification,
      idCollegers: entity.idCollegers,
      status: entity.status,
    );
  }
}
