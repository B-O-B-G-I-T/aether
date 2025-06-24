import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../commun/peer_config/presentation/bloc/peer_config_bloc.dart';
import '../../../../service_locator.dart';
import '../bloc/user_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            final user = state.user;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(radius: 50, backgroundColor: Colors.white, child: Icon(Icons.person, size: 50, color: Colors.blue[600])),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(icon: Icons.device_hub, title: 'Nom de l\'appareil', value: user.device.deviceName, isEditable: false),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.description,
                            title: 'Description',
                            value: user.device.deviceDescription ?? 'Non définie',
                            isEditable: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        sl<UserBloc>().add(DeleteUserEvent());
                        sl<PeerConfigBloc>().add(DisconnectPeerConfigEvent());
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Déconnexion'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String title, required String value, required bool isEditable}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600]),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (isEditable)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // TODO: Implémenter l'édition
              },
            ),
        ],
      ),
    );
  }
}
