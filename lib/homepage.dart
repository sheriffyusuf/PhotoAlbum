import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("My First App"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            width: 500.0,
            height: 500.0,
            color: Colors.pink,
            child: Column(
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    color: Colors.teal,
                    child: Text("Welcome to my App"))
              ],
            )),
      ),
    );
  }
}
