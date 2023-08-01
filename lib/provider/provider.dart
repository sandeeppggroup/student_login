import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/data_model.dart';

class ProviderClass with ChangeNotifier{
    List<StudentModel>studentList = [];
    List<StudentModel>studentSearchResult=[];
  Icon cusIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text(
    "Student records",
  );

  set setStudentSearchResult(List<StudentModel> list){
    studentSearchResult=list;
    notifyListeners();
  }



Future<int> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.put(value.id, value);
log('hello');
  getAllStudent();
notifyListeners();
  return 0;
}

Future<void> deleteStudent(context, String id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
  getAllStudent();
  notifyListeners();
}

Future<void> updateStudent(StudentModel model) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.put(model.id, model);
  getAllStudent();
  notifyListeners();
}

Future<void> getAllStudent() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentList.clear();
  studentList.addAll(studentDB.values);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  notifyListeners();
}

Future<void> search(String text) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');

  studentList.clear();
  studentList
      .addAll(studentDB.values.where((element) => element.name.contains(text)));
  notifyListeners();
}

static of(BuildContext ctx,{required bool listen}){}

void transform(){
  if (cusIcon.icon == Icons.search) {
                  cusIcon = const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  );
                  customSearchBar = TextField(
                    onChanged: (value) {
                      search(value);
                    },
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Search',
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  cusIcon = const Icon(
                    Icons.search,
                    color: Colors.black,
                  );
                  customSearchBar = const Text("Student records");
                }
                notifyListeners();
}


}