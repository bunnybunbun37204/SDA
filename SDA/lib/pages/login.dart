import 'package:SDA/api/myapi.dart';
import 'package:SDA/models/login_models.dart';
import 'package:SDA/models/users_model.dart';
import 'package:SDA/pages/register.dart';
import 'package:SDA/pages/userpages/patient_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SDA/progress.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //variables
  bool hidePassword = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalkey = new GlobalKey<FormState>();
  LoginRequest loginRequest;
  bool isProcess = false;

  @override
  void initState() {
    super.initState();
    loginRequest = new LoginRequest();
  }

  bool validateAndsave() {
    final form = globalkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<Null> routeToPages(Widget widget, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('id', userModel.id);
    sharedPreferences.setString('email', userModel.email);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(
      context,
      route,
      (route) => false,
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
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
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
                      ),
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
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => loginRequest.email = input,
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
                          onSaved: (input) => loginRequest.password = input,
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
                          height: 30,//13
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
                              myAPI.login(loginRequest).then((value) {
                                setState(
                                  () {
                                    isProcess = false;
                                  },
                                );
                                if (value != null) {
                                  final SnackBar _snackBar = SnackBar(
                                    content: Text("Login is Complete"),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(_snackBar);
                                  routeToPages(
                                      PateintHOmePage(), value["model"]);
                                } else if (value == "null") {
                                  final SnackBar _snackBar = SnackBar(
                                    content:
                                        Text("user or password is not valid"),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(_snackBar);
                                } else {
                                  final SnackBar _snackBar = SnackBar(
                                    content: Text(value),
                                  );
                                  scaffoldKey.currentState
                                      .showSnackBar(_snackBar);
                                }
                              });
                              print(loginRequest.toJson());
                            }
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("or"),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 80,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
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
