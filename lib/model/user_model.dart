class UserModel {
  String? uid;
  String? fullname;
  String? email;
  
  final String? password;

  UserModel({
    this.uid,
    this.fullname,
    this.password,
    this.email,
    
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
     
    );
  }
}
