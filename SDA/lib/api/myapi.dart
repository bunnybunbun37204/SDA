import 'dart:async';
import 'dart:convert';
import 'package:SDA/models/login_models.dart';
import 'package:SDA/models/register_model.dart';
import 'package:SDA/models/users_model.dart';
import 'package:dio/dio.dart';

class MyAPI {
  Future<dynamic> login(LoginRequest request) async {
    String user = request.email.trim();
    String password = request.password.trim();
    String url =
        "https://gameapisda.000webhostapp.com/getUser.php?isAdd=true&User=$user";
    try {
      Response response = await Dio().get(url);
      var result = jsonDecode(response.data);
      if (response.data == "null") {
        return "null";
      }
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
         return {"user": "Patient", "model": userModel};
        } else {
          return "password is not valid or user not found";
        }
      }
    } catch (e) {
      return e;
    }
  }

  Future<String> register(RegisterRequest request) async {
    String email = request.email.trim();
    String password = request.password.trim();
    String url =
        "https://gameapisda.000webhostapp.com/addUser.php?isAdd=true&Email=$email&Password=$password";
    print(url);
    try {
      await Dio().get(url);
      return "ok";
    } catch (e) {
      return e;
    }
  }

  Future<String> checkExistUser(RegisterRequest registerRequest) async {
    String user = registerRequest.email.trim();
    String url =
        "https://gameapisda.000webhostapp.com/getUser.php?isAdd=true&User=$user";
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        return "ok";
      } else {
        return "the email has been used";
      }
    } catch (e) {
      return e;
    }
  }
}
