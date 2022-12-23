import 'package:demo5/model/todo_model.dart';
import 'package:demo5/screen/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite/sqflite.dart';

class AddTodo extends StatelessWidget {
  var editingControllerForTitle = TextEditingController();
  var editingControllerForDesc = TextEditingController();

  final Database database;

  AddTodo({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo  "),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(TodoList(database: database));
            },
            icon: Icon(
              Icons.list_alt_outlined,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: editingControllerForTitle,
              decoration: InputDecoration(
                hintText: "Add title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: editingControllerForDesc,
              decoration: InputDecoration(
                hintText: "Add description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                saveTodoOnPressed();
                FocusScopeNode currentFocus = FocusScope.of(context);
                currentFocus.unfocus();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveTodoOnPressed() {
    database.insert(
        'todo',
        TodoModel(
                title: editingControllerForTitle.text,
                description: editingControllerForDesc.text)
            .toMap());
  }
}
