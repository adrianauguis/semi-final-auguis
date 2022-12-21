import 'package:flutter/material.dart';

class TodoInfo extends StatelessWidget {
  final dynamic mapResponse;
  const TodoInfo({Key? key, required this.mapResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status = mapResponse['completed'] == true ? "Finished" : "Unfinished";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo info'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title: ${mapResponse['title']}"),
              const SizedBox(height: 5),
              Text("User ID: ${mapResponse['userId'].toString()}"),
              const SizedBox(height: 5),
              Text("ID: ${mapResponse['id'].toString()}"),
              const SizedBox(height: 5),
              Text("Status: $status"),
            ],
          ),
        )
    );
  }
}
