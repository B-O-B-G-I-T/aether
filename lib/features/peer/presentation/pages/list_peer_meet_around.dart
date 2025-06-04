import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPeerMeetAround extends StatelessWidget {
  const ListPeerMeetAround({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des utilisateurs')),
      body: BlocProvider(
        create: (context) => PeerBloc()..add(GetKnownPeersEvent()),
        child: BlocBuilder<PeerBloc, PeerState>(
          builder: (context, state) {
            if (state is PeerLoaded) {
              return ListView.builder(
                itemCount: state.peers.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(state.peers[index].device.deviceId));
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
