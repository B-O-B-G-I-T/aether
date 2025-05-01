import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commun/functions_utils/utils.dart';
import '../bloc/notication_in_screen_bloc/notification_chat_bloc.dart';
import 'custom_snackbar.dart';

class NotificationManager extends StatelessWidget {
  final Widget child;

  const NotificationManager({super.key, required this.child});


  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationChatBloc, NotificationChatState>(
      listener: (context, state) {
        if (state is NotificationChatLoaded) {
          final bloc = context.read<NotificationChatBloc>();
          for (final message in bloc.activeSnackBars) {
            // Ne pas afficher la notification si l'utilisateur est dans le chat avec l'expéditeur
            if (!Utils.isInChatWithSender(context, message)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomSnackBar(
                    message: message,
                    onDismiss: () {
                      bloc.add(DismissSnackBar(message));
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  duration: const Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              );
            }
          }
        }
      },
      child: child,
    );
  }
}
