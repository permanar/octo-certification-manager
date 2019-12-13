import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CertificationEntity extends Equatable {
  final String id;
  final Category category;
  final String description;
  final String image;
  final Major major;
  final String name;
  final String price;
  final String taken_on;

  CertificationEntity({
    this.id,
    this.name,
    this.category,
    this.description,
    this.image,
    this.major,
    this.price,
    this.taken_on,
  });

  static CertificationEntity fromJson(Map<String, Object> json) {
    return CertificationEntity(
      id: json["id"],
      category: Category.fromJson(json["category"]),
      description: json["description"],
      image: json["image"],
      major: Major.fromJson(json["major"]),
      name: json["name"],
      price: json["price"],
      taken_on: json["taken_on"],
    );
  }

  Map<String, Object> toJson() {
    return {
      "id": id,
      "category": category.toJson(),
      "description": description,
      "image": image,
      "major": major.toJson(),
      "name": name,
      "price": price,
      "taken_on": taken_on,
    };
  }

  static CertificationEntity fromSnapshot(DocumentSnapshot snap) {
    return CertificationEntity(
      id: snap.documentID,
      category: Category.fromSnapshot(snap.data['category']),
      description: snap.data['description'],
      image: snap.data['image'],
      major: Major.fromSnapshot(snap.data['major']),
      name: snap.data['name'],
      price: snap.data['price'],
      taken_on: snap.data['taken_on'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "category": category.toDocument(),
      "description": description,
      "image": image,
      "major": major.toDocument(),
      "name": name,
      "price": price,
      "taken_on": taken_on,
    };
  }

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'CertificationEntity { category: $category, description: $description, image: $image, major: $major, name: $name, price: $price, taken_on: $taken_on}';
  }
}

class Category extends Equatable {
  final bool mi;
  final bool si;
  final bool sk;

  Category({
    this.mi,
    this.si,
    this.sk,
  });

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      mi: json["mi"],
      si: json["si"],
      sk: json["sk"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mi": mi,
      "si": si,
      "sk": sk,
    };
  }

  static Category fromSnapshot(Map<dynamic, dynamic> snap) {
    return Category(
      mi: snap['mi'],
      si: snap['si'],
      sk: snap['sk'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "mi": mi,
      "si": si,
      "sk": sk,
    };
  }

  @override
  List<Object> get props => [];
}

class Major extends Equatable {
  final Elective elective;
  final bool enterprise;
  final bool etourism;
  final bool intelligent;
  final bool multimedia;
  final bool networking;
  final bool robotika;

  Major({
    this.elective,
    this.enterprise,
    this.etourism,
    this.intelligent,
    this.multimedia,
    this.networking,
    this.robotika,
  });

  static Major fromJson(Map<String, dynamic> json) {
    return Major(
      elective: Elective.fromJson(json["elective"]),
      enterprise: json["enterprise"],
      etourism: json["etourism"],
      intelligent: json["intelligent"],
      multimedia: json["multimedia"],
      networking: json["networking"],
      robotika: json["robotika"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "elective": elective.toJson(),
      "enterprise": enterprise,
      "etourism": etourism,
      "intelligent": intelligent,
      "multimedia": multimedia,
      "networking": networking,
      "robotika": robotika,
    };
  }

  static Major fromSnapshot(Map<dynamic, dynamic> snap) {
    return Major(
      elective: Elective.fromSnapshot(snap['elective']),
      enterprise: snap['enterprise'],
      etourism: snap['etourism'],
      intelligent: snap['intelligent'],
      multimedia: snap['multimedia'],
      networking: snap['networking'],
      robotika: snap['robotika'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "elective": elective.toJson(),
      "enterprise": enterprise,
      "etourism": etourism,
      "intelligent": intelligent,
      "multimedia": multimedia,
      "networking": networking,
      "robotika": robotika,
    };
  }

  @override
  List<Object> get props => [];
}

class Elective extends Equatable {
  final bool si;
  final bool sk;

  Elective({
    this.si,
    this.sk,
  });

  static Elective fromJson(Map<String, dynamic> json) {
    return Elective(
      si: json["si"],
      sk: json["sk"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "si": si,
      "sk": sk,
    };
  }

  static Elective fromSnapshot(Map<dynamic, dynamic> snap) {
    return Elective(
      si: snap["si"],
      sk: snap["sk"],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "si": si,
      "sk": sk,
    };
  }

  @override
  List<Object> get props => [];
}
