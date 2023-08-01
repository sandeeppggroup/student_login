import 'dart:io';



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_login/provider/provider.dart';

import '../models/data_model.dart';
import 'update.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
 
  
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
  
      Provider.of<ProviderClass>(context).getAllStudent();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: context.read<ProviderClass>().customSearchBar),   
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          Consumer<ProviderClass>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  context.read<ProviderClass>().transform();
                },
                child: SizedBox(
                  width: 100,
                  child: value.cusIcon,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.purpleAccent,
        child: const Icon(
          Icons.add,
          color: Colors.deepPurpleAccent,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer<ProviderClass>(
        builder: (context, value, child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = value.studentList[index];
              // log(studentListNotifier.value[index].name);
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                elevation: 20,
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    tileColor: Colors.grey,
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            FileImage(File(value.studentList[index].img))),
                    title: Text(
                      data.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      data.age,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete?"),
                              content: const Text(
                                  "Are you sure you want to delete this item?"),
                              actions: [
                                Center(
                                    child: Image.asset(
                                  'images/delete.gif',
                                  height: 200,
                                  width: 200,
                                )),
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Delete"),
                                  onPressed: () {
                                    value.deleteStudent(
                                        ctx, data.id.toString());

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    onTap: () {
                      final student = StudentModel(
                          age: data.age,
                          name: data.name,
                          phone: data.phone,
                          domain: data.domain,
                          img: data.img,
                          id: data.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Updates(model: student),
                        ),
                      );
                    }),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: value.studentList.length,
          );
        },
      ),
    );
  }
}
