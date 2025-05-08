import 'package:aether/core/params/params.dart' show Params;
import 'package:equatable/equatable.dart';

import '../../features/chat/domain/entities/conversation_entity.dart';
import '../../features/chat/domain/entities/message_entity.dart';
import '../../features/peer/domain/entities/peer_entity.dart';

class ChatParams extends Equatable implements Params {
  @override
  List<Object?> get props => [];
}

class SendMessageParams extends ChatParams {
  final String content;
  final String receiverId;
  final String senderId;
  final String type;
  final String timestamp;

  SendMessageParams({required this.content, required this.receiverId, required this.senderId, required this.type, required this.timestamp});
}

class GetConversationsParams extends ChatParams {
  GetConversationsParams();
}

class UpdateConversationParams extends ChatParams {
  final ConversationEntity conversation;

  UpdateConversationParams({required this.conversation});
}


class GetConversationMessagesParams extends ChatParams {
  final PeerEntity peer;

  GetConversationMessagesParams({required this.peer});
}
