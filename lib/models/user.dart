class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final String displayName;
  final String email;
  final int photoUrl;

  UserData(this.uid, this.displayName, this.email, this.photoUrl,
      {required name});
}
