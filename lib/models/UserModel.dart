class UserModel {
  String? fullname;
  String? email;
  String? uid;
  String? profilepic;
  UserModel({this.email, this.fullname, this.profilepic, this.uid});
  UserModel.fromMap(Map<String, dynamic> map) {
    fullname = map['fullname'];
    email = map['email'];
    uid = map['uid'];
    profilepic = map['profilepic'];
  }
  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'email': email,
      'uid': uid,
      'profilepic': profilepic
    };
  }
}
