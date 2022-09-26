import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

String value = 'Press Enter';

class MyHomePageState extends State<MyHomePage> {
  Future genderPredict(String name) async {
    final url = Uri.parse("https://api.genderize.io/?name=$name");
    var res = await http.get(url);
    var body = jsonDecode(res.body);
    setState(() {
      value = body['gender'];
      // print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController gender = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                  controller: gender,
                  decoration: const InputDecoration(
                      label: Text("Enter Your Name"),
                      border: InputBorder.none)),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () => genderPredict(gender.text),
              child: const Text(
                "Enter",
                style: TextStyle(color: Colors.red),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.blue),
            height: 40,
            width: 140,
            child: Center(child: Text('Answer: $value')),
          )
        ],
      ),
    );
  }
}
