import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/device_list_item.dart';

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


