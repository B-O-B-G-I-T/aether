import 'dart:async';
import 'dart:convert';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../commun/peer_config/presentation/bloc/peer_config_bloc.dart';
import '../../../../core/errors/app_logger.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<Stream<List<MessageModel>>> initChat({required PeerParams peerParams});
  Future<MessageModel> sendMessage({required SendMessageParams params});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl();

  @override
  Future<Stream<List<MessageModel>>> initChat({required PeerParams peerParams}) async {
    try {
      final NearbyService nearbyService = (sl<PeerConfigBloc>().state as PeerConfigInitialised).nearbyService;

      final StreamController<List<MessageModel>> controller = StreamController<List<MessageModel>>.broadcast();

      nearbyService.dataReceivedSubscription(
        callback: (data) async {
          try {
            if (data['message'] == null) {
              AppLogger.e('Erreur: message est null');
              return;
            }

            MessageModel chatMessageModel = await manageDataReceivedToJson(data);
            controller.add([chatMessageModel]);
          } catch (e) {
            AppLogger.e('Erreur lors du traitement du message: $e');
            controller.addError(e);
          }
        },
      );

      // Gérer la fermeture du controller
      controller.onCancel = () {
        controller.close();
      };

      return controller.stream;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<MessageModel> manageDataReceivedToJson(data) async {
    var jsonData = jsonDecode(data['message']);

    MessageModel chatMessageModel = MessageModel.fromJson(json: jsonData);
    // String imagesEncode = chatMessageModel.images;
    // if (imagesEncode != "") {
    //   List<String> imageListPaths = await Utils.base64StringToListImage(imagesEncode);
    //   imagesEncode = imageListPaths.join(',');
    // }
    // chatMessageModel.images = imagesEncode;
    return chatMessageModel;
  }

  @override
  Future<MessageModel> sendMessage({required SendMessageParams params}) async {
    try {
      final NearbyService nearbyService = (sl<PeerConfigBloc>().state as PeerConfigInitialised).nearbyService;
      final MessageModel messageModel = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: params.content,
        conversationId: params.sendTo,
        timestamp: DateTime.now(),
        type: params.type,
      );

      nearbyService.sendMessage(params.sendTo, jsonEncode(messageModel.toJson()));

      return messageModel;
    } catch (e) {
      throw ServerException();
    }
  }


}