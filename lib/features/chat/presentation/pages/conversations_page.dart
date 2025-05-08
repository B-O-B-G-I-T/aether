import 'package:aether/core/route/route_name.dart';
import 'package:aether/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:aether/features/chat/presentation/bloc/conversation_bloc/conversations_bloc.dart';
import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:go_router/go_router.dart';
import '../../../../service_locator.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../../../user/presentation/bloc/user_bloc.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversations')),
      body: BlocBuilder<ConversationsBloc, ConversationsState>(
        builder: (context, state) {
          if (state is ConversationsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ConversationsError) {
            return Center(child: Text('Erreur: ${state.failure.errorMessage}'));
          } else if (state is ConversationsLoaded) {
            return ListView.builder(
              itemCount: state.conversations.length,
              itemBuilder: (context, index) {
                final conversation = state.conversations[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(conversation.peerName),
                  subtitle: Text(conversation.lastMessage?.content ?? 'Aucun message', maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Text(
                    '${conversation.lastActivity.hour}:${conversation.lastActivity.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onTap: () {
                    final SessionState state = (sl<PeerBloc>().state as PeerLoaded).peers.where((peer) => peer.device.deviceId == conversation.peerId).first.device.state;
                    final device = Device(conversation.peerId, conversation.peerName, state);
                    final peer = PeerEntity(device: device, description: conversation.description);
                    context.push(chatRoute, extra: peer);
                  },
                );
              },
            );
          }
          return const Center(child: Text('Initialisation...'));
        },
      ),
    );
  }
}
