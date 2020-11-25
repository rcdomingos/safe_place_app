class User {
  int id;
  String name;
  String email;
  String password;

  User({this.id, this.name, this.email, this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Password'] = this.password;
    return data;
  }
}
