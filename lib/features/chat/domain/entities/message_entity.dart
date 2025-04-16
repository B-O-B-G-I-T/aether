 
 class MessageEntity {
  final String id;
  final String content;
  final String senderId;
  final String receiverId;
  final DateTime timestamp;

  MessageEntity({required this.id, required this.content, required this.senderId, required this.receiverId, required this.timestamp});
 }  