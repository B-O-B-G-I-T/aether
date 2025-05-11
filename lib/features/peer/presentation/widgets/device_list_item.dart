import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/route/route_name.dart';
import '../../domain/entities/peer_entity.dart';
import 'connection_state_button.dart';

class DeviceListItem extends StatelessWidget {
  final PeerEntity peer;

  const DeviceListItem({super.key, required this.peer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(chatRoute, extra: peer);
      },
      title: Text(peer.device.deviceName),
      subtitle: Text(peer.device.deviceDescription ?? ''),
      trailing: ConnectionStateButton(peer: peer),
    );
  }
}
