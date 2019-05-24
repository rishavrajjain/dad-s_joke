import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  Future<String> response;

  initState() {
    super.initState();
    response = http.read(dadJokeApi, headers: httpHeaders);
  }
  _refreshAction() {
    setState(() {
      response = http.read(dadJokeApi, headers: httpHeaders);
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('Dad Jokes'),centerTitle: true, backgroundColor: Colors.redAccent,),

      body: new Center(
        child: new FutureBuilder<String>(
          future: response,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Icon(Icons.sync_problem);
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                final decoded = json.decode(snapshot.data);
                if (decoded['status'] == 200) {
                  return new Text(decoded['joke'],style: TextStyle(
                      fontFamily: 'Patrick Hand',
                      fontSize: 34.0,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),);
                } else {
                  return const Icon(Icons.error);
                }
            }
          },
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _refreshAction,
        tooltip: 'New joke',
        child: new Icon(Icons.refresh),
        backgroundColor: Colors.red,
      ),
    );
  }
}
