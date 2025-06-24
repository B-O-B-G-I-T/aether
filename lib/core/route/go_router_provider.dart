import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/conversation/presentation/pages/conversation_page.dart';
import '../../features/peer/domain/entities/peer_entity.dart';
import '../../features/peer/presentation/pages/list_peer_meet_around.dart';
import '../../features/peer/presentation/pages/peer_around_page.dart';
import '../../features/qr_code/presentation/pages/qr_code_page.dart';
import '../../features/user/presentation/pages/user_page.dart';
import '../../layout_scaffold.dart';
import 'route_name.dart';

// GoRouter configuration
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final router = GoRouter(
  //navigatorKey: _rootNavigatorKey,
  initialLocation: peerRoute,
  redirect: (context, state) async {
    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return LayoutScaffold(key: _rootNavigatorKey, navigationShell: navigationShell);
      },
      branches: [
        // route pour la page de recherche
        StatefulShellBranch(routes: [GoRoute(path: connectionRoute, builder: (context, state) => const ListPeerMeetAround())]),

        // route pour la page de favoris
        StatefulShellBranch(routes: [GoRoute(path: conversationsRoute, builder: (context, state) => const ConversationPage())]),
        // route pour la page d'accueil
        StatefulShellBranch(
          routes: [
            GoRoute(path: peerRoute, builder: (context, state) => const PeerPage()),
            GoRoute(
              path: chatRoute,
              builder: (context, state) {
                final peer = state.extra as PeerEntity;
                return ChatPage(peer: peer);
              },
            ),
          ],
        ),

        // route pour la page de qr code
        StatefulShellBranch(routes: [GoRoute(path: qrCodeRoute, builder: (context, state) => const QRCodeGeneratePage())]),

        // route pour la page de compte
        StatefulShellBranch(routes: [GoRoute(path: userRoute, builder: (context, state) => const UserPage())]),
      ],
    ),

    // autre
    // GoRoute(path: homeRoute, builder: (context, state) => const TemplatePage()),
  ],
);
