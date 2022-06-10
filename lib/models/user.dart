class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final String country;

  UserData(this.uid, this.displayName, this.email, this.photoUrl, this.country);
}
