import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_table/json_table.dart';

void main() {
  runApp(const MaterialApp(
    home: InitialPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing Django',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 220, 199),
        appBar: AppBar(
          leading: CircleAvatar(
            child: Image.network(
                'https://www.bennett.edu.in/wp-content/themes/twentysixteen/cdn/images/logo.png'),
          ),
          centerTitle: true,
          title: const Text(
            "Student Results",
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
            ),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              children: [
                Card(
                  color: Colors.orange.shade200,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Bennett University Student Results Platform',
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Color.fromARGB(255, 63, 63, 63),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans Pro',
                        // decoration: TextDecoration.underline,
                        // decorationStyle: TextDecorationStyle.solid,
                        // decorationColor: Colors.orange.shade500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const MyApp();
                      },
                    ),
                  ),
                  label: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Click here to view your results",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Color.fromARGB(255, 63, 63, 63),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans Pro',
                        decoration: TextDecoration.none,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.web),
                  // style: ElevatedButton.styleFrom(
                  //   textStyle: const TextStyle(
                  //     fontSize: 30,
                  //     fontFamily: 'Source Sans Pro',
                  //     letterSpacing: 1,
                  //     height: 4.0,
                  //     // backgroundColor: Colors.orange.shade400),
                  //   ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<Map<String, dynamic>> buttonPressed() async {
    http.Response returnedResult = await http.get(
        Uri.parse('http://localhost:8000/result/E20CSE302'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
    return jsonDecode(returnedResult.body);
  }

  // Future<int> totalee() async {
  //   http.Response returnedResult = await http.get(
  //       Uri.parse('http://localhost:8000/totale/'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset-UTF-8'
  //       });
  //   return jsonDecode(returnedResult.body);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Results Viewer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 235, 220, 199),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const InitialPage();
              },
            ),
          ),
          label: const Text('Go back'),
          icon: const Icon(Icons.arrow_back),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Student Results"),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Card(
                  color: Colors.orange.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Here's your result for E20CSE302",
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Source Sans Pro',
                        // decoration: TextDecoration.underline,
                        // decorationStyle: TextDecorationStyle.solid,
                        decorationColor: Colors.orange.shade500,
                      ),
                    ),
                  ),
                ),
              ),
              FutureBuilder<Map<String, dynamic>>(
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView(
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Subject-wise marks of the current semester:',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        JsonTable(
                          snapshot.data!["subjects"]!,
                          allowRowHighlight: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Colors.orange.shade300,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Total Marks: ${snapshot.data!['total_marks']}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Source Sans Pro',
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid,
                                  decorationColor: Colors.orange.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.orange.shade400,
                          child: const Center(
                            child: Text(
                              'Refer to the below Marks-Grade comparison for your referece',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Source Sans Pro',
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Image.network('https://i.imgur.com/h9puh3z.png')
                      ],
                    ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
                future: buttonPressed(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
