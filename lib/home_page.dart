import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'todo_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const String baseUrl = "https://jsonplaceholder.typicode.com/todos";

class _HomePageState extends State<HomePage> {
  List mapResponse = <dynamic>[];

  getTodo()async{
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);

    if(response.statusCode == 200){
      setState(() {
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
    getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Semi-final Exam'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: mapResponse.length,
            itemBuilder: (context, index){
              return CheckboxListTile(
                  title: Text(mapResponse[index]['title']),
                  subtitle: Text("ID: ${mapResponse[index]['id'].toString()}"),
                  value: mapResponse[index]['completed'],
                  controlAffinity: ListTileControlAffinity.leading,
                  secondary: IconButton(
                      onPressed: ()async{
                        await Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>TodoInfo(index: index,todos: mapResponse[index])));
                      },
                      icon: const Icon(Icons.info_outline)),

                  onChanged: (value){
                    setState(() {
                      mapResponse[index]['completed'] = value;
                    });
                  });
            })


    );
  }
}
