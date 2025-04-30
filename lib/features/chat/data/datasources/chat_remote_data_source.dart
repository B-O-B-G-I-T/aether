import 'dart:async';
import 'dart:convert';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../commun/config/peer_config/presentation/bloc/peer_config_bloc.dart';
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

      final StreamController<List<MessageModel>> controller = StreamController();

      nearbyService.dataReceivedSubscription(
        callback: (data) async {
          try {
            if (data['message'] == null) {
              AppLogger.e('Erreur: message est null');
              return;
            }
            final List<MessageModel> messages = [];
            // Vérifiez si data est une chaîne JSON valide

            // if (data['message'].startsWith("ACK ")) {
            //   // Enregistre le message dans la base de données
            //   final String messageId = data['message'].substring(4);
            //   final ChatMessageEntity messageACK = chat.firstWhere((element) => element.id == messageId);
            //   messageACK.ack = 1;

            //   await eitherFailureOrEnregistreMessage(chatMessageParams: messageACK.toParamsAKC());
            //   return;
            // }

            // if (data['message'].startsWith("PROFILE IMAGE ")) {
            //   if (data['message'].substring(14).isNotEmpty) {
            //     final dataMessage = data['message'].substring(14);

            //     final UserParams userParams = UserParams(id: data["senderDeviceId"], name: data["senderDeviceId"], pathImageProfile: dataMessage);
            //     //debugPrint("statement $userParams");

            //     await eitherFailureOrSaveSendedImageProfile(userParams: userParams);
            //   }
            //   notifyListeners();
            //   return;
            // }
            // passse les data en JSON
            MessageModel chatMessageModel = await manageDataReceivedToJson(data);

            messages.add(chatMessageModel);

            controller.add(messages);

            // if (chatMessageModel.type == 'DELETE') {
            //   // Enregistre le message supprimé dans la base de données
            //   await eitherFailureOrDeleteMessage(chatMessageEntity: chatMessageModel);

            //   await eitherFailureOrEnregistreMessage(chatMessageParams: chatMessageModel.toChatMessageParams());
            // } else {
            //   // enregistre le message dans la base de données et envoie ack
            //   await receiveMessage(chatMessageModel: chatMessageModel, nearbyService: nearbyService);
            // }
          } catch (e) {
            throw ServerException();
          }
        },
      );

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
        senderId: params.senderId,
        receiverId: params.receiverId,
        timestamp: DateTime.now(),
        type: params.type,
      );

      nearbyService.sendMessage(params.receiverId, jsonEncode(messageModel.toJson()));

      return messageModel;
    } catch (e) {
      throw ServerException();
    }
  }
}
