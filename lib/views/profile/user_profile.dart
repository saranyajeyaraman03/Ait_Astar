class UserProfile {
  final String name;
  final String contact;
  final String bio;
  final String country;
  final String city;
  final String address;
  final String profileUrl;
  final String subscriptionCount;
  final String cashAppName;
  final String dob;

  UserProfile({
    required this.name,
    required this.contact,
    required this.bio,
    required this.country,
    required this.city,
    required this.address,
    required this.profileUrl,
    required this.subscriptionCount,
    required this.cashAppName,
    required this.dob,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      bio: json['bio'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      profileUrl: json['p_picture'] ?? '',
      subscriptionCount: json['subscribers'].toString(),
      cashAppName: json['cash_app_name'] ?? '',
      dob: json['age'] ?? '',
    );
  }
}
