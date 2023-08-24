import 'dart:io';

class Student {
  int? id;
  String name;
  String age;
  String phone;
  File? image;

  Student(
      {required this.age, required this.name, required this.phone, this.image,this.id});

  static Student fromMap(Map<String, Object?> map) {
    return Student(
      id: map['id']as int,
      name: map['name']as String,
      age: map['age']as String,
      phone: map['phone']as String,
      image: map['image']as String == '' ? null : File(map['image']as String),
    );
  }
}
