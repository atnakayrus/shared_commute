class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? displayPic;
  String? pNo;
  String? dob;

  UserModel(
      {this.uid,
      this.displayName,
      this.email,
      this.displayPic,
      this.pNo,
      this.dob});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['display_name'];
    email = json['email'];
    displayPic = json['display_pic'];
    pNo = json['p_no'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['display_name'] = displayName;
    data['email'] = email;
    data['display_pic'] = displayPic;
    data['p_no'] = pNo;
    data['dob'] = dob;
    return data;
  }
}
