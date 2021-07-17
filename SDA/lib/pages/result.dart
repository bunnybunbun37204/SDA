import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  Widget appBar() {
    return AppBar(
      title: Text(
        "Resut",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(),body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Text('Tinea 87.3%',style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 10,),
          Text('Pityriasis 30%',style: Theme.of(context).textTheme.headline6,),
        ],),
      ),
    ),);
  }
}
