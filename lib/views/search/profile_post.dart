class ProfileAndPosts {
  final UserProfile userProfile;
  final List<AllPost> allPosts;
  final bool isSubscribed;

  ProfileAndPosts({
    required this.userProfile,
    required this.allPosts,
    required this.isSubscribed,
  });

  factory ProfileAndPosts.fromJson(Map<String, dynamic> json) {
    return ProfileAndPosts(
      userProfile: UserProfile.fromJson(json['profile'][0]),
      allPosts: List<AllPost>.from(
          json['all_posts'].map((postData) => AllPost.fromJson(postData))),
      isSubscribed: json['is_subscribed'],
    );
  }
}

class UserProfile {
  final int id;
  final int userId;
  final String pPicture;
  final bool isSubscriptionOk;
  final String name;
  final String userType;
  final String address;
  final String bio;
  final int subscribers;
  final int followers;
  final String contact;
  final String cashAppName;
  final String stripeCustomerId;
  final String state;
  final String zipcode;
  final bool isBank;
  final bool registerSubscription;

  UserProfile({
    required this.id,
    required this.userId,
    required this.pPicture,
    required this.isSubscriptionOk,
    required this.name,
    required this.userType,
    required this.address,
    required this.bio,
    required this.subscribers,
    required this.followers,
    required this.contact,
    required this.cashAppName,
    required this.stripeCustomerId,
    required this.state,
    required this.zipcode,
    required this.isBank,
    required this.registerSubscription,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
  return UserProfile(
    id: json['id'],
    userId: json['user_id'],
    pPicture: json['p_picture'] ?? '',
    isSubscriptionOk: json['is_subscription_ok'] ?? false,
    name: json['name'] ?? '',
    userType: json['user_type'] ?? '',
    address: json['address'] ?? '',
    bio: json['bio'] ?? '',
    subscribers: json['subscribers'] ?? 0,
    followers: json['followers'] ?? 0,
    contact: json['contact'] ?? '',
    cashAppName: json['cash_app_name'] ?? '',
    stripeCustomerId: json['stripe_customer_id'] ?? '',
    state: json['state'] ?? '',
    zipcode: json['zipcode'] ?? '',
    isBank: json['is_bank'] ?? false,
    registerSubscription: json['register_subscription'] ?? false,
  );
}

}


class AllPost {
  final UserProfile userProfile; 
  final int id;
  final int userId;
  final bool status;
  final int postType;
  final String name;
  final String description;
  final String link;
  final int type;
  final String file;
  final DateTime createdAt;

  AllPost({
    required this.userProfile,
    required this.id,
    required this.userId,
    required this.status,
    required this.postType,
    required this.name,
    required this.description,
    required this.link,
    required this.type,
    required this.file,
    required this.createdAt,
  });

  factory AllPost.fromJson(Map<String, dynamic> json) {
  return AllPost(
    userProfile: UserProfile.fromJson(json), 
    id: json['id'],
    userId: json['user_id'],
    status: json['status'] ?? false, 
    postType: json['post_type'] ?? 0, 
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    link: json['link'] ?? '',
    type: json['type'] ?? 0,
    file: json['file'] ?? '',
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now(), 
  );
}

}

