import 'package:aether/core/route/route_name.dart';
import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/device_list_item.dart';

class PeerPage extends StatelessWidget {
  const PeerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PeerBloc, PeerState>(
        builder: (context, state) {
          if (state is PeerLoaded) {
            if (state.peers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Aucun peer trouvé autour de vous'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.go(qrCodeRoute);
                      },
                      child: const Text('Montrer leur l\'application avec le QR code'),
                    ),
                  ],
                ),
              );
            }
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
