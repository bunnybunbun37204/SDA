import 'package:SDA/pages/result.dart';
import 'package:flutter/material.dart';

class Form_predict extends StatefulWidget {
  @override
  _Form_predictState createState() => _Form_predictState();
}

enum Answer { True, False }

class _Form_predictState extends State<Form_predict> {
  Answer ans = Answer.True;
  Widget appBar() {
    return AppBar(
      title: Text(
        "FORM",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget question1() {
    return Container(
      child: Stack(
        children: [
          Center(
              child: Text(
            "คุณทำงานที่อับชื้นหรือไม่",
            style: Theme.of(context).textTheme.headline5,
          )),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget question2() {
    return Container(
      child: Stack(
        children: [
          Center(
              child: Text(
            "คันตามผิวหนังใช่หรือไม่",
            style: Theme.of(context).textTheme.headline5,
          )),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                question1(),
                ListTile(
                  title: const Text('True'),
                  leading: Radio(
                    value: Answer.True,
                    groupValue: ans,
                    onChanged: (value) {
                      setState(() {
                        ans = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  title: const Text('False'),
                  leading: Radio(
                    value: Answer.False,
                    groupValue: ans,
                    onChanged: (value) {
                      setState(() {
                        ans = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8.0,),
                question2(),
                ListTile(
                  title: const Text('True'),
                  leading: Radio(
                    value: Answer.True,
                    groupValue: ans,
                    onChanged: (value) {
                      setState(() {
                        ans = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ListTile(
                  title: const Text('False'),
                  leading: Radio(
                    value: Answer.False,
                    groupValue: ans,
                    onChanged: (value) {
                      setState(() {
                        ans = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8.0,),
                Container(
              width: 360.0,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  "LET'S SEE",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Result(),
                      ));
                },
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
