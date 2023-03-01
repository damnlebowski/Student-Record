// ignore_for_file: avoid_init_to_null, prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record/screens/screen_home.dart';

import '../db/functions/db_functions.dart';
import '../db/model/data_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.index, required this.passValueProfile})
      : super(key: key);

  StudentModel passValueProfile;
  int index;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final _nameController =
      TextEditingController(text: widget.passValueProfile.name);

  late final _ageController =
      TextEditingController(text: widget.passValueProfile.age);

  late final _emailController =
      TextEditingController(text: widget.passValueProfile.email);

  late final _numController =
      TextEditingController(text: widget.passValueProfile.phone);

  String? imagePath;

  Future<void> studentAddBtn(int index) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final email = _emailController.text.trim();
    final number = _numController.text.trim();

    if (name.isEmpty || age.isEmpty || number.isEmpty) {
      return;
    }

    final students = StudentModel(
      name: name,
      age: age,
      email: email,
      phone: number,
      image: imagePath ?? widget.passValueProfile.image,
    );
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, students);
    getAllStudents();
  }

  Future<void> takePhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
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

  Widget dpImage() {
    return InkWell(
      child: CircleAvatar(radius: 75, backgroundImage: backImage()),
      onTap: () {
        takePhoto();
      },
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              const SizedBox(height: 20),
              textFieldCall(
                  ht: 'Enter Your Name', lt: 'Name', control: _nameController),
              const SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Age',
                  lt: 'Age',
                  control: _ageController,
                  kt: TextInputType.number,
                  ml: 2),
              const SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Email',
                  lt: 'Email',
                  control: _emailController,
                  kt: TextInputType.emailAddress),
              const SizedBox(height: 10),
              textFieldCall(
                  ht: 'Enter Your Phone Number',
                  lt: 'Phone Number',
                  control: _numController,
                  kt: TextInputType.number,
                  ml: 10),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    studentAddBtn(widget.index);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => const HomePage()),
                        (route) => false);
                  },
                  child: const Text('Update')),
            ]),
          ),
        ));
  }

  backImage() {
    if (imagePath == null && widget.passValueProfile.image == 'x') {
      return const AssetImage('assests/avatar.png');
    } else if (imagePath != null && widget.passValueProfile.image != 'x') {
      return FileImage(File(imagePath!));
    } else if (imagePath == null && widget.passValueProfile.image != 'x') {
      return FileImage(File(widget.passValueProfile.image!));
    } else {
      return FileImage(File(imagePath!));
    }
  }
}
