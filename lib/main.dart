import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
Future<List<Person>> fetchPersons() async {
    final response = await http
        .get(Uri.parse('http://localhost/irrigation/irrigation.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var listPerson = jsonDecode(response.body) as List;
      List<Person> persons = listPerson.map((json)=>Person.fromJson(json)).toList();
      return persons;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load persons');
    }
  }
class Person {
  final String name;
  final String city;
  final String job;

  

  Person({
    required this.name,
    required this.city,
    required this.job,
  });

  factory Person.fromJson(Map<dynamic, dynamic> json) {
    return Person(
      name: json['name'],
      city: json['city'],
      job: json['job'],
    );
  }
}

Future<http.Response> fetch() async {
  return await http.get(Uri.parse('https://restapi/firstapi'));
}

void main() {
  runApp(MaterialApp(
    title: "ListPersons",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  late Future<List<Person>> futurePersons;

  @override
  void initState() {
    super.initState();
    futurePersons = fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("persons"),
      ),
      body: FutureBuilder<List>(
            future: futurePersons,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
          child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Center(child:Text('${snapshot.data![index].name}'));
              }));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
    );
  }
}
