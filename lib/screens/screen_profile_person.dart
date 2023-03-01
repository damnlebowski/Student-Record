// ignore_for_file: must_be_immutable, prefer_const_constructors, non_constant_identifier_names, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_record/screens/screen_edit_person.dart';
import '../db/model/data_model.dart';

class ProfilePage extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;

  ProfilePage({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  StudentModel passValue;
  final int passId;

  Widget CoverImage() => Container(
        color: Color.fromARGB(253, 28, 97, 165),
        width: double.infinity,
        height: coverHeight,
      );

  Widget ProfileImage() => CircleAvatar(
        backgroundImage: passValue.image == 'x'
            ? AssetImage('assests/avatar.png') as ImageProvider
            : FileImage(File(passValue.image!)),
        radius: profileHeight / 2,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfile(
                        passValueProfile: passValue,
                        index: passId,
                      )));
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(child: ProfileImage()),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name                     '),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Age                       '),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Email                   '),
                  SizedBox(
                    height: 25,
                  ),
                  Text('Phone                   '),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(passValue.name),
                  SizedBox(
                    height: 25,
                  ),
                  Text(passValue.age),
                  SizedBox(
                    height: 25,
                  ),
                  Text('${passValue.email}'),
                  SizedBox(
                    height: 25,
                  ),
                  Text(passValue.phone),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close')),
        ],
      )),
    );
  }
}
