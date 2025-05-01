import 'package:flutter/material.dart';
import '../../../../commun/peer_config/presentation/bloc/peer_config_bloc.dart';
import '../../../../service_locator.dart';
import '../bloc/user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User'),
            ElevatedButton(
              onPressed: () {
                sl<UserBloc>().add(DeleteUserEvent());
                sl<PeerConfigBloc>().add(DisconnectPeerConfigEvent());
              },
              child: const Text('Déconnexion'),
            ),
          ],
        ),
      ),
    );
  }
}
