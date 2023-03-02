import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record/screens/screen_profile_person.dart';
import '../db/model/data_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<StudentModel> studentList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

//function or widgets-------------------------------------------------------

  Widget expanded() {
    return Expanded(
      child: studentDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentDisplay.length,
              itemBuilder: (context, index) {
                // final data = studentList[index];
                File img = File(studentDisplay[index].image!);
                return ListTile(
                  leading: CircleAvatar(   
                    backgroundImage: FileImage(img),
                    // studentDisplay[index].image.toString(),
                    radius: 22,
                  ),
                  title: Text(studentDisplay[index].name),
                  // subtitle: Text(
                  //     '${studentDisplay[index]["age"].toString()} years old'),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  passValue:studentDisplay[index],
                                  passId: index,
                                )));
                  }),
                );
              },
            )
          : const Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget searchTextField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration:
          InputDecoration(labelText: 'Search', suffixIcon: Icon(Icons.search)),
      onChanged: (value) {
        _searchStudent(value);
      },
    );
  }

//setstate
  void _searchStudent(String value) {
    setState(() {
      studentDisplay = studentList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    _searchController.clear();
  }

  //builder-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(),
              expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
