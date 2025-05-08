import 'package:aether/features/chat/data/models/message_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/constants/chat_constants.dart';
import '../../../../core/constants/conversation_constants.dart';
import '../../../../core/constants/peer_constant.dart';
import 'message_entity.dart';

class ConversationEntity extends Equatable {
  final String id;
  final String peerId;
  final String peerName;
  final String? description;
  final MessageEntity? lastMessage;
  final DateTime lastActivity;

  const ConversationEntity({
    required this.id,
    required this.peerId,
    required this.peerName,
    required this.description,
    this.lastMessage,
    required this.lastActivity,
  });

  Map<String, dynamic> toJson() {
    return {
      kId: id,
      kSenderId: peerId,
      kPeerName: peerName,
      kPeerDescription: description,
      kLastMessage: lastMessage?.toJson(),
      kLastActivity: lastActivity.toIso8601String(),
    };
  }

  factory ConversationEntity.fromJson(Map<String, dynamic> json) {
    MessageModel? lastMessage;
    // todo: fix this
    // if (json[kLastMessage] != null) {
    //   if (json[kLastMessage] is String) {
    //     lastMessage = MessageModel.fromJson(json: jsonDecode(json[kLastMessage]));
    //   } else {
    //     lastMessage = MessageModel.fromJson(json: json[kLastMessage]);
    //   }
    // }

    return ConversationEntity(
      id: json[kId],
      peerId: json[kSenderId],
      peerName: json[kPeerName],
      description: json[kPeerDescription],
      lastMessage: lastMessage,
      lastActivity: DateTime.parse(json[kLastActivity]),
    );
  }

  @override
  List<Object?> get props => [id, peerId, peerName, lastMessage, lastActivity];
}
