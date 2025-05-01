import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commun/functions_utils/utils.dart';
import '../bloc/notication_in_screen_bloc/notification_chat_bloc.dart';
import '../../domain/entities/message_entity.dart';

class NotificationPreview extends StatelessWidget {
  const NotificationPreview({super.key});

  List<MessageEntity> _filterUnreadMessages(BuildContext context, List<MessageEntity> messages) {
    return messages.where((message) => !Utils.isInChatWithSender(context, message)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationChatBloc, NotificationChatState>(
      builder: (context, state) {
        if (state is NotificationChatLoaded && state.unreadMessages.isNotEmpty) {
          final filteredMessages = _filterUnreadMessages(context, state.unreadMessages);
          if (filteredMessages.isEmpty) {
            return const Icon(Icons.notifications_none);
          }
          return PopupMenuButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      filteredMessages.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onCanceled: () {
              context.read<NotificationChatBloc>().add(ClearNotification());
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Messages non lus (${filteredMessages.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        ...filteredMessages.map(
                          (message) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.message, size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('De: ${message.senderId}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      Text(message.content, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
                                      Text(
                                        '${message.timestamp.hour}:${message.timestamp.minute}',
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.read<NotificationChatBloc>().add(ClearNotification());
                              Navigator.pop(context);
                            },
                            child: const Text('Tout effacer'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          );
        }
        return const Icon(Icons.notifications_none);
      },
    );
  }
}
