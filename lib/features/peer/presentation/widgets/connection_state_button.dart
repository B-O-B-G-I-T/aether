import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../domain/entities/peer_entity.dart';
import '../bloc/peer_bloc.dart';

class ConnectionStateButton extends StatelessWidget {
  final PeerEntity peer;
  const ConnectionStateButton({super.key, required this.peer});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeerBloc, PeerState>(
      builder: (context, state) {
        IconData icon;
        Color color;
        String tooltip;

        if (peer.device.state == SessionState.connected) {
          icon = Icons.wifi;
          color = Colors.green;
          tooltip = 'Connecté';
        } else if (peer.device.state == SessionState.connecting) {
          icon = Icons.wifi_find;
          color = Colors.orange;
          tooltip = 'Connexion en cours...';
        } else if (peer.device.state == SessionState.notConnected) {
          icon = Icons.wifi_off;
          color = Colors.grey;
          tooltip = 'Déconnecté';
        } else {
          icon = Icons.wifi_off;
          color = Colors.red;
          tooltip = 'Erreur de connexion';
        }

        return IconButton(
          icon: Icon(icon, color: color),
          tooltip: tooltip,
          onPressed: () {
            if (peer.device.state == SessionState.connected) {
              context.read<PeerBloc>().add(DisconnectPeerEvent(device: peer.device));
            } else {
              context.read<PeerBloc>().add(InvitePeerEvent(device: peer.device));
            }
          },
        );
      },
    );
  }
}
