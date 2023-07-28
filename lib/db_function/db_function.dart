import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<int> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.put(value.id, value);

  getAllStudent();

  return 0;
}

Future<void> deleteStudent(context, String id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getAllStudent();
}

Future<void> updateStudent(StudentModel model) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.put(model.id, model);
}

Future<void> getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
  log(studentDB.values.length);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future<void> search(String text) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentListNotifier.value.clear();
  studentListNotifier.value
      .addAll(studentDB.values.where((element) => element.name.contains(text)));
  studentListNotifier.notifyListeners();
}
