import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/params/chat_params.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../../../peer/presentation/widgets/connection_state_button.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../data/models/message_model.dart';
import '../../domain/entities/conversation_entity.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../../domain/entities/message_entity.dart';
import '../bloc/conversation_bloc/conversations_bloc.dart';

class ChatPage extends StatefulWidget {
  final PeerEntity peer;
  const ChatPage({super.key, required this.peer});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;
  
  @override
  void initState() {
    super.initState();

    context.read<ChatBloc>().add(GetConversationMessagesEvent(peer: widget.peer));
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels < _scrollController.position.maxScrollExtent - 100) {
      if (!_showScrollButton) {
        setState(() {
          _showScrollButton = true;
        });
      }
    } else {
      if (_showScrollButton) {
        setState(() {
          _showScrollButton = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat P2P'), actions: [ConnectionStateButton(peer: widget.peer)]),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure.errorMessage)));
                    }

                  },
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChatError) {
                      return Center(child: Text('Erreur: ${state.failure.errorMessage}'));
                    } else if (state is ChatLoaded) {
                      if (state.messages.isEmpty) {
                        return const Center(child: Text('Aucun message'));
                      }

                      if (context.read<ConversationsBloc>().state is ConversationsLoaded) {
                        final conversationsState = context.read<ConversationsBloc>().state as ConversationsLoaded;
                        final existingConversation =
                            conversationsState.conversations.where((conversation) => conversation.id == widget.peer.device.deviceId).firstOrNull;

                        if (existingConversation == null) {
                          context.read<ConversationsBloc>().add(
                            AddConversation(
                              conversation: ConversationEntity(
                                id: widget.peer.device.deviceId,
                                peerId: widget.peer.device.deviceId,
                                peerName: widget.peer.device.deviceName,
                                description: widget.peer.description,
                                lastMessage: state.messages.last as MessageModel,
                                lastActivity: DateTime.now(),
                              ),
                            ),
                          );
                        }
                      }
                      final reverseList = state.messages.reversed.toList();

                      return ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        controller: _scrollController,
                        itemCount: reverseList.length,
                        itemBuilder: (context, index) {
                          final message = reverseList[index];
                          return MessageBubble(message: message);
                        },
                      );
                    }

                    return const Center(child: Text('Initialisation...'));
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          ),
          if (_showScrollButton)
            Positioned(
              right: 20,
              bottom: 80,
              child: FloatingActionButton(mini: true, onPressed: _scrollToBottom, child: const Icon(Icons.arrow_downward)),
            ),
        ],
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
