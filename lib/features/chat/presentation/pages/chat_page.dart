import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/params/chat_params.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../../../peer/presentation/widgets/connection_state_button.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../../domain/entities/message_entity.dart';

class ChatPage extends StatefulWidget {
  final PeerEntity peer;
  const ChatPage({super.key, required this.peer});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat P2P'), actions: [ConnectionStateButton(peer: widget.peer)]),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatError) {
            return Center(child: Text('Erreur: ${state.failure.errorMessage}'));
          } else if (state is ChatLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      return MessageBubble(message: message);
                    },
                  ),
                ),
                _buildMessageInput(),
              ],
            );
          }
          return const Center(child: Text('Initialisation...'));
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(hintText: 'Écrivez votre message...', border: OutlineInputBorder()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                if (context.read<UserBloc>().state is UserLoaded) {
                  final currentUserId = (context.read<UserBloc>().state as UserLoaded).user.displayName;
                  final params = SendMessageParams(
                    content: _messageController.text,
                    receiverId: widget.peer.device.deviceId,
                    senderId: currentUserId,
                    type: 'text',
                    timestamp: DateTime.now().toIso8601String(),
                  );
                  context.read<ChatBloc>().add(SendMessageEvent(message: params));
                }
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageEntity message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = false;
    if (context.read<UserBloc>().state is UserLoaded) {
      final currentUserId = (context.read<UserBloc>().state as UserLoaded).user.displayName;
      isMe = message.senderId == currentUserId; // À adapter selon votre logique d'identification
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isMe ? 'Moi' : message.senderId,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: isMe ? Colors.red : Colors.grey),
          ),
          const SizedBox(height: 2),
          Text(message.content, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, color: Colors.black)),
          Text(
            '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
