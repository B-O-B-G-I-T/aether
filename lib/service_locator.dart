
import 'package:aether/features/chat/domain/usecases/get_initialisation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/chat/data/datasources/chat_local_data_source.dart';
import 'features/chat/data/datasources/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/chat/presentation/bloc/chat_bloc.dart';
import 'features/peer/data/datasources/peer_local_data_source.dart';
import 'features/peer/data/datasources/peer_remote_data_source.dart';
import 'features/peer/data/repositories/peer_repository_impl.dart';
import 'features/peer/domain/repositories/peer_repository.dart';
import 'features/peer/domain/usecases/get_check_around.dart';
import 'features/peer/presentation/bloc/peer_bloc.dart';
import 'features/template/data/datasources/template_local_data_source.dart';
import 'features/template/data/datasources/template_remote_data_source.dart';
import 'features/template/data/repositories/template_repository_impl.dart';
import 'features/template/domain/repositories/template_repository.dart';
import 'features/template/domain/usecases/get_template.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeApp() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
}

Future<void> setupServiceLocator() async {
  await initializeApp();

  setUpTemplateServiceLocator();
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

void setUpChatServiceLocator() {
  // datasource
  sl.registerSingleton<ChatRemoteDataSource>(ChatRemoteDataSourceImpl());
  sl.registerSingleton<ChatLocalDataSource>(ChatLocalDataSourceImpl());
  // repository
  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl());

  // Usecase
  sl.registerSingleton<GetInitialisation>(GetInitialisation());
  
  // Bloc
  sl.registerSingleton<ChatBloc>(ChatBloc());
}

  void setUpPeerServiceLocator() {
  // datasource
  sl.registerSingleton<PeerRemoteDataSource>(PeerRemoteDataSourceImpl());
  sl.registerSingleton<PeerLocalDataSource>(PeerLocalDataSourceImpl());

  // repository
  sl.registerSingleton<PeerRepository>(PeerRepositoryImpl());

  // Usecase
  sl.registerSingleton<GetPeer>(GetPeer());

  // Bloc
  sl.registerSingleton<PeerBloc>(PeerBloc());
}

