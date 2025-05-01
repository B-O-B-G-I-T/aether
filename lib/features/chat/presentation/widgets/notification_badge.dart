import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notication_in_screen_bloc/notification_chat_bloc.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationChatBloc, NotificationChatState>(
      builder: (context, state) {
        if (state is NotificationChatLoaded && state.unreadMessages.isNotEmpty) {
          return Stack(
            children: [
              const Icon(Icons.notifications),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    state.unreadMessages.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
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
