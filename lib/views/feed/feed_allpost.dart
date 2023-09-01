import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedProfileAndPosts {
  final UserProfile userProfile;
  final List<AllPost> allPosts;
  final bool isSubscribed;
  final int subscribedCount;

  FeedProfileAndPosts({
    required this.userProfile,
    required this.allPosts,
    required this.isSubscribed,
    required this.subscribedCount
  });

  factory FeedProfileAndPosts.fromJson(Map<String, dynamic> json) {
    return FeedProfileAndPosts(
      userProfile: UserProfile.fromJson(json['profile'][0]),
      allPosts: List<AllPost>.from(
          json['all_posts'].map((postData) => AllPost.fromJson(postData))),
      isSubscribed: json['is_subscribed'],
      subscribedCount: json['subscribed_count'],
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
  final DateTime date;
  final TimeOfDay time;

  AllPost(
      {required this.userProfile,
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
      required this.date,
      required this.time});

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
      date: json['date'] != null
          ? DateFormat("yyyy-MM-dd").parse(json['date'])
          : DateTime.now(),
      time: json['time'] != null
          ? _parseTimeOfDay(json['time'])
          : TimeOfDay.now(),
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    if (parts.length == 2) {
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    }
    return TimeOfDay.now();
  }

  String get formattedDate {
    return DateFormat("MMM. dd, yyyy").format(date);
  }

  String get formattedTime {
    return DateFormat.jm().format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
          time.hour, time.minute),
    );
  }
}
