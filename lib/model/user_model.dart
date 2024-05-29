
class UserModel{
  final String uid,email,fullName,password;
  const UserModel(
      {
        required this.uid,
        required this.email,
        required this.fullName,
        required this.password,
      });

  Map<String,dynamic> toJson(){
    return {
      'uid' : uid,
      'email' : email,
      'fullName' : fullName,
      'password' : password,
     };
  }

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        uid: json['uid'],
        email: json['email'],
        fullName: json['fullName'],
        password: json['password'],
     );
  }
}