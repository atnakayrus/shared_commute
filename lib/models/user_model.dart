class UserModel {
  String? uid;
  String? displayName;
  String? email;

  UserModel({this.uid, this.displayName, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['display_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['display_name'] = displayName;
    data['email'] = email;
    return data;
  }
}
