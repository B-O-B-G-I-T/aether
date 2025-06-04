class ConversationEntity  {
  final String lastMessage;
  final String lastActivity;
  final String peerId;
  const ConversationEntity({
    required this.lastMessage,
    required this.lastActivity,
    required this.peerId,
  });
}
