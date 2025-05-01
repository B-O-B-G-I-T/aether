import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'commun/peer_config/data/datasources/database_config.dart';
import 'commun/peer_config/data/datasources/peer_config_local_data_source.dart';
import 'commun/peer_config/data/datasources/peer_config_remote_data_source.dart';
import 'commun/peer_config/data/repositories/peer_config_repository_impl.dart';
import 'commun/peer_config/domain/repositories/peer_config_repository.dart';
import 'commun/peer_config/domain/usecases/disconnect_peer_config.dart';
import 'commun/peer_config/domain/usecases/get_init_peer_config.dart';
import 'commun/peer_config/presentation/bloc/peer_config_bloc.dart';
import 'features/chat/data/datasources/chat_local_data_source.dart';
import 'features/chat/data/datasources/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/chat/domain/usecases/get_conversation_messages.dart';
import 'features/chat/domain/usecases/init_chat.dart';
import 'features/chat/domain/usecases/send_message.dart';
import 'features/chat/presentation/bloc/notication_in_screen_bloc/notification_chat_bloc.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/peer/data/datasources/peer_local_data_source.dart';
import 'features/peer/data/datasources/peer_remote_data_source.dart';
import 'features/peer/data/repositories/peer_repository_impl.dart';
import 'features/peer/domain/repositories/peer_repository.dart';
import 'features/peer/domain/usecases/disconnect_peer.dart';
import 'features/peer/domain/usecases/get_check_around.dart';
import 'features/peer/domain/usecases/invite_peer.dart';
import 'features/peer/presentation/bloc/peer_bloc.dart';
import 'features/template/data/datasources/template_local_data_source.dart';
import 'features/template/data/datasources/template_remote_data_source.dart';
import 'features/template/data/repositories/template_repository_impl.dart';
import 'features/template/domain/repositories/template_repository.dart';
import 'features/template/domain/usecases/get_template.dart';
import 'features/user/data/datasources/user_local_data_source.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/usecases/disconnect.dart';
import 'features/user/domain/usecases/get_user.dart';
import 'features/user/domain/usecases/set_user.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeApp() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerSingleton<DatabaseConfig>(DatabaseConfig.instance);

}
Future<void> setupServiceLocator() async {
  await initializeApp();

  setUpTemplateServiceLocator();
  setUpPeerConfigServiceLocator();
  setUpChatServiceLocator();
  setUpPeerServiceLocator();
  setUpNotificationServiceLocator();
  setUpUserServiceLocator();
}

void setUpTemplateServiceLocator() {
  // services
  sl.registerSingleton<TemplateLocalDataSourceImpl>(TemplateLocalDataSourceImpl());
  sl.registerSingleton<TemplateRemoteDataSourceImpl>(TemplateRemoteDataSourceImpl());

  // repository
  sl.registerSingleton<TemplateRepository>(TemplateRepositoryImpl());

  // Usecase
  sl.registerSingleton<GetTemplate>(GetTemplate());

  // Bloc
  // sl.registerSingleton<TarifBloc>(TarifBloc());
}

void setUpUserServiceLocator() {
  // datasource
  sl.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImpl());
  sl.registerSingleton<UserLocalDataSource>(UserLocalDataSourceImpl());

  // repository
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());

  // Usecase
  sl.registerSingleton<GetUser>(GetUser());
  sl.registerSingleton<SetUser>(SetUser());
  sl.registerSingleton<Disconnect>(Disconnect());
  // Bloc
  sl.registerSingleton<UserBloc>(UserBloc());
}

void setUpPeerConfigServiceLocator() {
  // datasource
  sl.registerSingleton<PeerConfigRemoteDataSource>(PeerConfigRemoteDataSourceImpl());
  sl.registerSingleton<PeerConfigLocalDataSource>(PeerConfigLocalDataSourceImpl());

  // repository
  sl.registerSingleton<PeerConfigRepository>(PeerConfigRepositoryImpl());

  // Usecase
  sl.registerSingleton<GetInitPeerConfig>(GetInitPeerConfig());
  sl.registerSingleton<DisconnectPeerConfig>(DisconnectPeerConfig());

  // Bloc
  sl.registerSingleton<PeerConfigBloc>(PeerConfigBloc());
}

void setUpChatServiceLocator() {
  // datasource
  sl.registerSingleton<ChatRemoteDataSource>(ChatRemoteDataSourceImpl());
  sl.registerSingleton<ChatLocalDataSource>(ChatLocalDataSourceImpl());
  // repository
  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl());

  // Usecase
  sl.registerSingleton<InitChat>(InitChat());
  sl.registerSingleton<SendMessage>(SendMessage());

  // Bloc
  sl.registerSingleton<ChatBloc>(ChatBloc());
  sl.registerSingleton<GetConversationMessages>(GetConversationMessages());
}

void setUpPeerServiceLocator() {
  // datasource
  sl.registerSingleton<PeerRemoteDataSource>(PeerRemoteDataSourceImpl());
  sl.registerSingleton<PeerLocalDataSource>(PeerLocalDataSourceImpl());

  // repository
  sl.registerSingleton<PeerRepository>(PeerRepositoryImpl());

  // Usecase
  sl.registerSingleton<GetCheckAround>(GetCheckAround());
  sl.registerSingleton<InvitePeer>(InvitePeer());
  sl.registerSingleton<DisconnectPeer>(DisconnectPeer());
  // Bloc
  sl.registerSingleton<PeerBloc>(PeerBloc());
}

void setUpNotificationServiceLocator() {
  // Bloc
  sl.registerSingleton<NotificationChatBloc>(NotificationChatBloc());
}
