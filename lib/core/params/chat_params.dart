import 'package:aether/core/params/params.dart' show Params;
import 'package:equatable/equatable.dart';


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
