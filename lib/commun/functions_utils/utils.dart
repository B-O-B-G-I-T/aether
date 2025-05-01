import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/route/route_name.dart';
import '../../features/chat/domain/entities/message_entity.dart';
import '../../features/peer/domain/entities/peer_entity.dart';

class Utils {
  static bool isInChatWithSender(BuildContext context, MessageEntity message) {
    final currentRoute = GoRouterState.of(context).uri.path;
    if (currentRoute.contains(chatRoute)) {
      final extra = GoRouterState.of(context).extra as PeerEntity;

      // Vérifier si l'utilisateur est dans le chat avec l'expéditeur du message
      return extra.device.deviceId == message.senderId;
    }
    return false;
  }
}
