import 'package:demo5/screen/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await openDatabase(
    join(await getDatabasesPath(), 'myapp.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT, title varchar(255), description varchar(255))',
      );
    },
    version: 1,
  );

  Get.put(database);

  runApp(MyApp(
    database: database,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});

  final Database database;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: AddTodo(
          database: database,
        ));
  }
}
