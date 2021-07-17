import 'package:SDA/api/myapi.dart';
import 'package:SDA/models/register_model.dart';
import 'package:SDA/pages/userpages/patient_home.dart';
import 'package:SDA/progress.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //variables
  bool hidePassword = true;
  bool _hidePassword = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalkey = new GlobalKey<FormState>();
  RegisterRequest registerRequest;
  bool isProcess = false;
  String _password;
  String dropDownValue = "Patient";

  @override
  void initState() {
    super.initState();
    registerRequest = new RegisterRequest();
    checkPreference();
  }

  Future<Null> checkPreference() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String type = sharedPreferences.getString('chooseType');
      if (type != null && type.isNotEmpty) {
        if (type == 'Doctor') {
        } else {
          final SnackBar _snackBar = SnackBar(
            content: Text('ERROR CANT FIND USER'),
          );
          scaffoldKey.currentState.showSnackBar(_snackBar);
        }
      }
    } catch (e) {

    }
  }

  void routeToPage(Widget widget) {
    MaterialPageRoute materialPageRoute = new MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(
      context,
      materialPageRoute,
      (route) => false,
    );
  }

  bool validateAndsave() {
    final form = globalkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget dropDown() {
    return DropdownButton<String>(
      value: dropDownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Theme.of(context).accentColor,
      ),
      underline: Container(
        height: 2,
        color: Theme.of(context).accentColor,
      ),
      onChanged: (String newValue) {
        setState(
          () {
            dropDownValue = newValue;
          },
        );
      },
      items: <String>['Doctor', 'Patient']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiset(context),
      inAsyncCall: isProcess,
      opacity: 0.3,
    );
  }

  Widget _uiset(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 85,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: Form(
                    key: globalkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => registerRequest.email = input,
                          validator: (input) => !input.contains("@")
                              ? "Email id should be valid"
                              : null,
                          decoration: new InputDecoration(
                            hintText: "Email address",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) {
                            _password = input;
                            print(_password);
                          },
                          validator: (input) => input.length < 5
                              ? "Password id should be more 5 charecters"
                              : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) {
                            registerRequest.password = input;
                          },
                          // validator: (input) =>
                          //     input != _password ? "valid password" : null,
                          obscureText: _hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Confirmed Password",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              icon: Icon(_hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Row(
                        //   children: [
                        //     Text("Choose Type :",
                        //         style: Theme.of(context).textTheme.bodyText1),
                        //     SizedBox(
                        //       width: 150,
                        //     ),
                        //     //dropDown(),
                        //   ],
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 80,
                          ),
                          onPressed: () {
                            if (validateAndsave()) {
                              setState(
                                () {
                                  isProcess = true;
                                },
                              );
                              MyAPI myAPI = new MyAPI();
                              myAPI.checkExistUser(registerRequest).then(
                                (value) {
                                  setState(
                                    () {
                                      isProcess = false;
                                    },
                                  );
                                  if (value == 'ok') {
                                    print("check mate");
                                    myAPI.register(registerRequest).then(
                                      (value) {
                                        if (value == "ok") {
                                          final SnackBar _snackBar = SnackBar(
                                            content:
                                                Text("Register is Complete"),
                                          );
                                          scaffoldKey.currentState
                                              .showSnackBar(_snackBar);
                                           MaterialPageRoute route =
                                                MaterialPageRoute(
                                              builder: (context) =>
                                                  PateintHOmePage(),
                                            );
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              route,
                                              (route) => false,
                                            );
                                        } else {
                                          final SnackBar _snackBar = SnackBar(
                                            content: Text(value),
                                          );
                                          scaffoldKey.currentState
                                              .showSnackBar(_snackBar);
                                        }
                                      },
                                    );
                                    print(registerRequest.toJson());
                                  } else {
                                    final SnackBar _snackBar = SnackBar(
                                      content: Text(value),
                                    );
                                    scaffoldKey.currentState
                                        .showSnackBar(_snackBar);
                                  }
                                },
                              );
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
