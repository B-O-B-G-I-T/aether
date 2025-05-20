import 'package:aether/features/conversation/domain/entities/conversation_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/conversation_bloc.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversations'), elevation: 0),
      body: BlocBuilder<ConversationBloc, ConversationState>(
        builder: (context, state) {
          if (state is ConversationLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ConversationLoaded) {
            return ListView.builder(
              itemCount: 10, // Pour l'exemple, nous affichons 10 conversations
              itemBuilder: (context, index) {
                final ConversationEntity conversationEntity = state.conversationEntity[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.primaries[index % Colors.primaries.length],
                      child: Text(conversationEntity.peerId, style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(conversationEntity.peerId),
                    subtitle: Text(conversationEntity.lastMessage),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigation vers le détail de la conversation
                    },
                  ),
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour créer une nouvelle conversation
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
