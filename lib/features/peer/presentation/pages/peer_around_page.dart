import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/peer_entity.dart';
import '../widgets/connection_state_button.dart';

class PeerPage extends StatelessWidget {
  const PeerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PeerBloc, PeerState>(
        builder: (context, state) {
          if (state is PeerLoaded) {
            return ListView.builder(
              itemCount: state.peers.length,
              itemBuilder: (context, index) {
                return DeviceListItem(peer: state.peers[index]);
              },
            );
          }
          if (state is PeerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PeerError) {
            return Center(child: Text(state.failure.toString()));
          }

          return Center(child: Text('Peer'));
        },
      ),
    );
  }
}

class DeviceListItem extends StatelessWidget {
  final PeerEntity peer;

  const DeviceListItem({super.key, required this.peer});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(peer.device.deviceName), subtitle: Text(peer.description ?? ''), trailing: ConnectionStateButton(peer: peer));
  }
}
