import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Certification {
  final String id;
  final Category category;
  final String description;
  final String image;
  final Major major;
  final String name;
  final String price;
  final String taken_on;

  Certification({
    this.id,
    this.category,
    this.description,
    this.image,
    this.major,
    this.name,
    this.price,
    this.taken_on,
  });

  Certification copyWith({
    String id,
    Category category,
    String description,
    String image,
    Major major,
    String name,
    String price,
    String taken_on,
  }) {
    return Certification(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      major: major ?? this.major,
      name: name ?? this.name,
      price: price ?? this.price,
      taken_on: taken_on ?? this.taken_on,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      category.hashCode ^
      description.hashCode ^
      image.hashCode ^
      major.hashCode ^
      name.hashCode ^
      price.hashCode ^
      taken_on.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Certification &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          category == other.category &&
          description == other.description &&
          image == other.image &&
          major == other.major &&
          name == other.name &&
          price == other.price &&
          taken_on == other.taken_on;

  @override
  String toString() {
    return 'Certification { category: $category, description: $description, image: $image, major: $major, name: $name, price: $price, taken_on: $taken_on}';
  }

  CertificationEntity toEntity() {
    return CertificationEntity(
      id: id,
      category: category,
      description: description,
      image: image,
      major: major,
      name: name,
      price: price,
      taken_on: taken_on,
    );
  }

  static Certification fromEntity(CertificationEntity entity) {
    print(entity.image);
    return Certification(
      id: entity.id,
      category: entity.category,
      description: entity.description,
      image: entity.image,
      major: entity.major,
      name: entity.name,
      price: entity.price,
      taken_on: entity.taken_on,
    );
  }
}
