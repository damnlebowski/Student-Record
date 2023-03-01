// ignore_for_file: prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers, avoid_init_to_null, prefer_const_constructors, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/functions/db_functions.dart';
import '../db/model/data_model.dart';

class AddPerson extends StatefulWidget {
  AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _numController = TextEditingController();
  String? imagePath = 'x';

  Future<void> fieldCheck(BuildContext context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _email = _emailController.text.trim();
    final _num = _numController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _email.isEmpty || _num.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
        name: _name,
        age: _age,
        phone: _num,
        email: _email,
        image: imagePath,
      );

      addStudent(_student);
      Navigator.of(context).pop();
    }
  }

  Future<void> takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
      });
    }
  }

  textFieldCall(
      {required ht, required lt, required control, kt = null, ml = null}) {
    return TextField(
      controller: control,
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: ht, labelText: lt),
      keyboardType: kt,
      maxLength: ml,
    );
  }

  Widget profileImage() {
    return InkWell(
      child: CircleAvatar(
        radius: 75,
        backgroundImage: imagePath == 'x'
            ? AssetImage('assests/avatar.png') as ImageProvider
            : FileImage(File(imagePath!)),
      ),
      onTap: () {
        takePhoto();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              profileImage(),
              SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Name', lt: 'Name', control: _nameController),
              SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Age',
                  lt: 'Age',
                  control: _ageController,
                  kt: TextInputType.number,
                  ml: 2),
              SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Email',
                  lt: 'Email',
                  control: _emailController,
                  kt: TextInputType.emailAddress),
              SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Phone Number',
                  lt: 'Phone Number',
                  control: _numController,
                  kt: TextInputType.number,
                  ml: 10),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel')),
                  SizedBox(width: 25),
                  ElevatedButton(
                      onPressed: () {
                        fieldCheck(context);
                      },
                      child: Text('Save')),
                ],
              ),
            ]),
          ),
        ));
  }

}
