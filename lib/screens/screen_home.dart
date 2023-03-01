// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_record/screens/screen_add_person.dart';
import 'package:student_record/screens/screen_search_person.dart';
import 'package:student_record/screens/widgets/list_of_students.dart';
import '../db/functions/db_functions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => SearchScreen())));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: StudentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          add(context);
        },
      ),
    );
  }

  add(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx1) => AddPerson()));
  }
}
