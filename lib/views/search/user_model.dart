class AthleteUserModel {
  int id;
  String username;
  String userType;
  // Other properties...

  AthleteUserModel({
    required this.id,
    required this.username,
    required this.userType,
    // Other properties...
  });

  factory AthleteUserModel.fromJson(Map<String, dynamic> json) {
    return AthleteUserModel(
      id: json['user']['id'],
      username: json['user']['username'],
      userType: json['user_type'],
      // Other properties...
    );
  }
}
