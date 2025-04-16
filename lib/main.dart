import 'package:aether/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:aether/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/route/go_router_provider.dart';

void main() {
  setUpChatServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ChatBloc())],
      child: MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: router),
    );
  }
}
