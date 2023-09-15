import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminUserData {
  final List<AdminPost> adminAllContents;
  final List<ProfileOfUser> profileOfUser;
  final List<Scraper> scraper;

  AdminUserData({
    required this.adminAllContents,
    required this.profileOfUser,
    required this.scraper,
  });

  factory AdminUserData.fromJson(Map<String, dynamic> json) {
    return AdminUserData(
      adminAllContents: List<AdminPost>.from(
        (json['admin_all_contents'] as List)
            .map((content) => AdminPost.fromJson(content)),
      ),
      profileOfUser: List<ProfileOfUser>.from(
        json['profile_of_user'].map((profile) => ProfileOfUser.fromJson(profile)),
      ),
      scraper: List<Scraper>.from(
        (json['scrapers'] as List)
            .map((content) => Scraper.fromJson(content)),
      ),
    );
  }
}

class Scraper {
  final int id;
  final int userId;
  final String link;
  

  Scraper({
    required this.id,
    required this.userId,
    required this.link,
  });

  factory Scraper.fromJson(Map<String, dynamic> json) {
    return Scraper(
      id: json['id'],
      userId: json['user_id'],
      link: json['link'] ?? '',
      
    );
  }
}


class AdminPost {
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

  AdminPost({
    required this.id,
    required this.userId,
    required this.status,
    required this.postType,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.link,
    required this.type,
    required this.file,
    required this.createdAt,
  });

  factory AdminPost.fromJson(Map<String, dynamic> json) {
    return AdminPost(
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



class ProfileOfUser {
  final int id;
  final int userId;
  final String pPicture;
  final bool isSubscriptionOk;
  final String? name;
  final String? country;
  final String? city;
  final String userType;
  final String address;
  final String bio;
  final int subscribers;
  final int followers;
  final String? contact;
  final String? cashAppName;
  final String? cashAppUsername;
  final String? stripeCustomerId;
  final String? state;
  final String? zipcode;
  final bool isBank;
  final bool registerSubscription;

  ProfileOfUser({
    required this.id,
    required this.userId,
    required this.pPicture,
    required this.isSubscriptionOk,
    required this.name,
    required this.country,
    required this.city,
    required this.userType,
    required this.address,
    required this.bio,
    required this.subscribers,
    required this.followers,
    required this.contact,
    required this.cashAppName,
    required this.cashAppUsername,
    required this.stripeCustomerId,
    required this.state,
    required this.zipcode,
    required this.isBank,
    required this.registerSubscription,
  });

  factory ProfileOfUser.fromJson(Map<String, dynamic> json) {
    return ProfileOfUser(
      id: json['id'],
      userId: json['user_id'],
      pPicture: json['p_picture'] ?? '',
      isSubscriptionOk: json['is_subscription_ok'] ?? false,
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      userType: json['user_type'] ?? '',
      address: json['address'] ?? '',
      bio: json['bio'] ?? '',
      subscribers: json['subscribers'] ?? 0,
      followers: json['followers'] ?? 0,
      contact: json['contact'] ?? '',
      cashAppName: json['cash_app_name'] ?? '',
      cashAppUsername: json['cash_app_username'] ?? '',
      stripeCustomerId: json['stripe_customer_id'] ?? '',
      state: json['state'] ?? '',
      zipcode: json['zipcode'] ?? '',
      isBank: json['is_bank'] ?? false,
      registerSubscription: json['register_subscription'] ?? false,
    );
  }
}
