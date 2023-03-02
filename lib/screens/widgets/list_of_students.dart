// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import '../../db/functions/db_functions.dart';
import '../../db/model/data_model.dart';
import '../screen_profile_person.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: ((ctx, index) {
            final data = studentList[index];
            return ListTile(
              leading: InkWell(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: data.image == 'x'
                      ? AssetImage('assests/avatar.png') as ImageProvider
                      : FileImage(File(data.image!)),
                ),
                onTap: () {
                  viewImage(context, data);
                },
              ),
              title: Text(data.name),
              subtitle: Text(''),
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              passId: index,
                              passValue: data,
                            )));
              }),
              trailing: IconButton(
                  onPressed: () {
                    deleteAlert(context, index);
                  },
                  icon: Icon(
                    Icons.delete,
                  )),
            );
          }),
          separatorBuilder: (ctx, index) {
            return Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }

  Future<dynamic> viewImage(BuildContext context, StudentModel data) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Center(
              child: Stack(children: [
            Container(
              color: Colors.grey,
              width: 300,
              height: 300,
              child: Image(
                image: data.image == 'x'
                    ? AssetImage('assests/avatar.png') as ImageProvider
                    : FileImage(File(data.image!)),
              ),
            ),
            Container(
              height: 25,
              width: 300,
              color: Colors.black.withOpacity(.5),
              child: Expanded(
                child: Text(
                  ' ${data.name}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ]));
        }));
  }
}

deleteAlert(BuildContext context, index) {
  showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('Are you sure you?'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(index);
                    Navigator.of(context).pop(ctx);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )));
}
