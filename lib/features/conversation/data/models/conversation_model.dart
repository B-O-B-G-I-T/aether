import '../../../../core/constants/conversation_constants.dart';
import '../../../../core/constants/peer_constant.dart';
import '../../domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  const ConversationModel({required super.lastMessage, required super.lastActivity, required super.peerId});

  factory ConversationModel.fromJson({required Map<String, dynamic> json}) {
    return ConversationModel(lastMessage: json[kLastMessage], lastActivity: json[kLastActivity], peerId: json[kPeerId]);
  }

  Map<String, dynamic> toJson() {
    return {kLastMessage: lastMessage, kLastActivity: lastActivity, kPeerId: peerId};
  }
}
