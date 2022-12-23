import 'package:demo5/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TodoList extends StatefulWidget {
  TodoList({Key? key, required this.database}) : super(key: key);
  final Database database;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: FutureBuilder<List<TodoModel>>(
          future: read(),
          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Center(
                          child: Text("${snapshot.data![index].id}"),
                        ),
                      ),
                      title: Text(
                        "${snapshot.data![index].title}",
                      ),
                      subtitle: Text(
                        "${snapshot.data![index].description}",
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          widget.database.delete(
                            'todo', where: 'id = ?',
                            // Pass the Dog's id as a whereArg to prevent SQL injection.
                            whereArgs: [snapshot.data![index].id],
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }
          }),
    );
  }

  Future<List<TodoModel>> read() async {
    List<Map<String, dynamic>> allData = await widget.database.rawQuery(
      "SELECT * FROM todo WHERE title=='abc' AND description=='453'",
    );

    print(allData.length > 0);

    List<TodoModel> data = List.generate(
        allData.length,
        (index) => TodoModel(
            id: allData[index]['id'],
            title: allData[index]['title'],
            description: allData[index]['description']));

    return data;
  }
}
