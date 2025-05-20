import 'package:flutter/material.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/errors/app_logger.dart';
import '../../../../core/params/peer_params.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../../domain/usecases/set_user.dart';
import '../../../../service_locator.dart';
import '../../../../commun/peer_config/presentation/bloc/peer_config_bloc.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final displayNameController = TextEditingController();
    final descriptionController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: Form(
        child: Column(
          children: [
            TextFormField(controller: displayNameController, decoration: InputDecoration(labelText: 'DisplayName')),
            TextFormField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
            ElevatedButton(
              onPressed: () async {
                final String displayName = displayNameController.text.trim();
                final String description = descriptionController.text.trim();
                final String deviceId = Uuid().v4();
                
                final device = Device(deviceId, displayName, SessionState.notConnected, deviceDescription: description);
                final user = SavePeersParams(peer: PeerEntity(device: device));
                final result = await sl<SetUser>().call(param: user);
                result.fold(
                  (failure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.errorMessage)));
                    AppLogger.e('CreateUserPage: Erreur lors de la création de l\'utilisateur - ${failure.errorMessage}');
                  },
                  (user) {
                    sl<PeerConfigBloc>().add(GetInitPeerConfigEvent());
                  },
                );
              },
              child: const Text('Create User'),
            ),
          ],
        ),
      ),
    );
  }
}
