import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SchedulesEntity extends Equatable {
  final String datetime;
  final String id;
  final String idCertification;
  final List idCollegers;
  final Status status;

  SchedulesEntity({
    this.datetime,
    this.id,
    this.idCertification,
    this.idCollegers,
    this.status,
  });

  static SchedulesEntity fromJson(Map<String, Object> json) {
    return SchedulesEntity(
      datetime: json["datetime"],
      id: json["id"],
      idCertification: json["id_certification"],
      idCollegers: json["id_collegers"],
      status: Status.fromJson(json["status"]),
    );
  }

  Map<String, Object> toJson() {
    return {
      "datetime": datetime,
      "id": id,
      "idCertification": idCertification,
      "idCollegers": idCollegers,
      "status": status.toJson(),
    };
  }

  static SchedulesEntity fromSnapshot(DocumentSnapshot snap) {
    return SchedulesEntity(
      datetime: snap["datetime"],
      id: snap["id"],
      idCertification: snap["id_certification"],
      idCollegers: snap["id_collegers"],
      status: Status.fromSnapshot(snap["status"]),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "datetime": datetime,
      "id": id,
      "idCertification": idCertification,
      "idCollegers": idCollegers,
      "status": status.toDocument(),
    };
  }

  @override
  List<Object> get props => [];
}

class Status extends Equatable {
  final bool finished;
  final bool full;
  final bool open;
  final bool started;

  Status({
    this.finished,
    this.full,
    this.open,
    this.started,
  });

  static Status fromJson(Map<String, dynamic> json) {
    return Status(
      finished: json["finished"],
      full: json["full"],
      open: json["open"],
      started: json["started"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "finished": finished,
      "full": full,
      "open": open,
      "started": started,
    };
  }

  static Status fromSnapshot(Map<dynamic, dynamic> snap) {
    return Status(
      finished: snap["finished"],
      full: snap["full"],
      open: snap["open"],
      started: snap["started"],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "finished": finished,
      "full": full,
      "open": open,
      "started": started,
    };
  }

  @override
  List<Object> get props => [];
}
