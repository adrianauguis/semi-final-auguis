import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoInfo extends StatefulWidget {
  final int index;
  TodoInfo({Key? key,required this.index}) : super(key: key);

  @override
  State<TodoInfo> createState() => _TodoInfoState();
}

class _TodoInfoState extends State<TodoInfo> {
  String baseUrl = "https://jsonplaceholder.typicode.com/todos";
  dynamic mapResponse = {};
  String? status;

  todoGet()async{
    var url = Uri.parse("$baseUrl/${widget.index+1}");
    var response = await http.get(url);

    if(response.statusCode == 200){
      setState((){
        mapResponse = jsonDecode(response.body);
      });
    }else{
      return null;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoGet();
  }

  @override
  Widget build(BuildContext context) {
    status = mapResponse['completed'] == true ? "Finished" : "Unfinished";
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
