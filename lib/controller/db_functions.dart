import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_getx/model/student_model.dart';

ValueNotifier<List<Student>> studentListNotifier = ValueNotifier([]);

class Sql with ChangeNotifier {
  //private constructor
  Sql._();

  // Singleton instance variable
  static final Sql _instance = Sql._();

  // Factory constructor to return the singleton instance
  factory Sql() => _instance;

  late Database db;

  Future initialiseDatabase() async {
    db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (db, version) async => await db.execute(
          'CREATE TABLE Student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, image TEXT)'),
    );
    await getData();
  }

  Future<bool> insertInToDb(Student model) async {
    try {
      String image = model.image == null ? '' : model.image!.path;
      db.rawInsert(
          'INSERT INTO Student(name, age, phone, image) VALUES(?, ?, ?, ?)',
          [model.name, model.age, model.phone, image]);
      await getData();
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> getData() async {
    List<Map<String, Object?>> list =
        await db.rawQuery('SELECT * FROM Student');
    studentListNotifier.value.clear();
    for (var map in list) {
      studentListNotifier.value.add(Student.fromMap(map));
      print(studentListNotifier.value.last.name);
    }
    studentListNotifier.notifyListeners();
    print(studentListNotifier.value);
  }

  Future<bool> updateTable(Student model) async {
    try {
      String image = model.image == null ? '' : model.image!.path;
      await db.rawUpdate(
          'UPDATE Student SET name= ?,age= ?,phone= ?,image=? WHERE id= ?',
          [model.name, model.age, model.phone, image, model.id]);
      await getData();
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> deleteData(int id) async {
    await db.delete(
      'Student',
      where: 'id = ?',
      whereArgs: [id],
    );
    studentListNotifier.value.removeWhere((element) => element.id == id);
    studentListNotifier.notifyListeners();
  }
}
