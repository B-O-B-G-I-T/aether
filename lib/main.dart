import 'package:aether/features/chat/presentation/bloc/init_chat_bloc/init_chat_bloc.dart';
import 'package:aether/features/chat/presentation/bloc/notication_in_screen_bloc/notification_chat_bloc.dart';
import 'package:aether/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'commun/peer_config/presentation/bloc/peer_config_bloc.dart';
import 'features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/conversation/presentation/bloc/conversation_bloc.dart';
import 'features/user/presentation/pages/create_user_page.dart';
import 'core/errors/app_logger.dart';
import 'core/route/go_router_provider.dart';
import 'features/peer/presentation/bloc/peer_bloc.dart';
import 'features/user/presentation/bloc/user_bloc.dart';

Future<void> main() async {
  // pour la gestion des pages
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<PeerConfigBloc>()..add(GetInitPeerConfigEvent())),
        BlocProvider(create: (context) => sl<PeerBloc>()),
        BlocProvider(create: (context) => sl<ConversationBloc>()),
        BlocProvider(create: (context) => sl<InitChatBloc>()),
        BlocProvider(create: (context) => sl<ChatBloc>()),
        BlocProvider(create: (context) => sl<NotificationChatBloc>()),
        BlocProvider(create: (context) => sl<UserBloc>()),
      ],

      child: BlocBuilder<PeerConfigBloc, PeerConfigState>(
        builder: (context, state) {
          // sl<DatabaseConfig>().clearDatabase();
          // sl<DatabaseConfig>().insertTestData();
          AppLogger.i('Main: État actuel - ${state.runtimeType}');
          if (state is PeerConfigInitialised) {
            AppLogger.i('Main: Configuration initialisée - Affichage de l\'application');
            return MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: router);
          } else if (state is PeerConfigLoading) {
            AppLogger.i('Main: Chargement en cours - Affichage du loader');
            return MaterialApp(debugShowCheckedModeBanner: false, home: const Scaffold(body: Center(child: CircularProgressIndicator())));
          } else if (state is PeerConfigUserNotLoaded) {
            AppLogger.i('Main: Utilisateur non chargé - Affichage de la page de création');
            return MaterialApp(debugShowCheckedModeBanner: false, home: const CreateUserPage());
          } else if (state is PeerConfigError) {
            AppLogger.e('Main: Erreur - ${state.failure.errorMessage}');
            return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(body: Center(child: Text('Erreur: ${state.failure.errorMessage}'))));
          } else {
            AppLogger.e('Main: État inconnu - ${state.runtimeType}');
            return MaterialApp(debugShowCheckedModeBanner: false, home: const Scaffold(body: Center(child: Text('État inconnu'))));
          }
        },
      ),
    );
  }
}
