class ChatMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}

class ChatConversationModel {
  final String sellerId;
  final String sellerName;
  final String lastMessage;
  final DateTime lastTimestamp;
  final int unreadCount;

  ChatConversationModel({
    required this.sellerId,
    required this.sellerName,
    required this.lastMessage,
    required this.lastTimestamp,
    this.unreadCount = 0,
  });
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });
}
