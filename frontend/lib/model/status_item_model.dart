class StatusItemModel {
  const StatusItemModel({
    required this.id,
    required this.content,
    required this.type,
    required this.userId,
    required this.userName,
    required this.userProfilePicUrl,
    this.url,
  });

  final String id;
  final String content;
  final String type;
  final String? url;
  final String userId;
  final String userName;
  final String userProfilePicUrl;

  factory StatusItemModel.fromMap(Map<String, dynamic> map) {
    final user = Map<String, dynamic>.from(map['user'] ?? <String, dynamic>{});
    return StatusItemModel(
      id: '${map['id']}',
      content: '${map['content'] ?? ''}',
      type: '${map['type'] ?? 'text'}',
      url: map['url']?.toString(),
      userId: '${map['userId']}',
      userName: '${user['name'] ?? 'Unknown'}',
      userProfilePicUrl: '${user['profilePicUrl'] ?? ''}',
    );
  }
}
