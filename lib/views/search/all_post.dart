class AllPost {
  final int id;
  final int userId;
  final String userType;
  final bool status;
  final int postType;
  final String name;
  final String description;
  final String link;
  final int type;
  final String file;
  final DateTime createdAt;

  AllPost({
    required this.id,
    required this.userId,
    required this.userType,
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
      id: json['id'],
      userId: json['user_id'],
      userType: json['user_type'],
      status: json['status'],
      postType: json['post_type'],
      name: json['name'],
      description: json['description'],
      link: json['link'],
      type: json['type'],
      file: json['file'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
