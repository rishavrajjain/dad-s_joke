import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const dadJokeApi = "https://icanhazdadjoke.com/";
const httpHeaders = const {
  'User-Agent': 'DadJokes (https://github.com/timsneath/dadjokes)',
  'Accept': 'application/json',
};
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent,title: new Text("Dad Jokes"),),
      body:
      new Container(
        margin: EdgeInsets.only(top: 410, left: 10),
        child:
        new RaisedButton(onPressed: getJson,
        color: Colors.redAccent,child: new Text("Send Data Back",style: TextStyle(fontSize: 20),), ),
      ) );
  }


  void getJson() async{


    final response = await http.read(dadJokeApi, headers: httpHeaders);
    final decoded = json.decode(response);
    if (decoded['status'] == 200) {
      print (decoded['joke']);
    }

  }
/*
  void updateTempWidget(BuildContext context) {
    new FutureBuilder(
        future: getJson(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData && snapshot.hasData != null) {
            String content;
            content = snapshot.data;
            print (content);
          }

        });
  }
*/






}

