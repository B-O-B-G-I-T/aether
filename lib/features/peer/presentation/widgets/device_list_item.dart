import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/route/route_name.dart';
import '../../../chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../../domain/entities/peer_entity.dart';
import 'connection_state_button.dart';

class DeviceListItem extends StatelessWidget {
  final PeerEntity peer;

  const DeviceListItem({super.key, required this.peer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<ChatBloc>().add(GetConversationMessagesEvent(peer: peer));
        context.push(chatRoute, extra: peer);
      },
      title: Text(peer.device.deviceName),
      subtitle: Text(peer.description ?? ''),
      trailing: ConnectionStateButton(peer: peer),
    );
  }
}
