enum Priority { normal, medium, high, critical }

class Notice {
  final String id;
  final String title;
  final String content;
  final Priority priority;
  final String timeAgo;
  final String expiryDate;
  final int commentsCount;
  final bool isUnread;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.timeAgo,
    required this.expiryDate,
    this.commentsCount = 0,
    this.isUnread = true,
  });
}
