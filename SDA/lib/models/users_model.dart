class UserModel {
  String id;
  String email;
  String password;

  UserModel({this.id, this.email, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Email'] = this.email;
    data['Password'] = this.password;
    return data;
  }
}
