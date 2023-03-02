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
          ? ListView.separated(
              itemBuilder: ((ctx, index) {
                final data = studentList[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: data.image == 'x'
                        ? AssetImage('assests/avatar.png') as ImageProvider
                        : FileImage(File(data.image!)),
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
                );
              }),
              separatorBuilder: (ctx, index) {
                return Divider();
              },
              itemCount: studentDisplay.length,
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
