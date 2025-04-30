import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/peer/domain/entities/peer_entity.dart';
import '../../features/peer/presentation/pages/peer_around_page.dart';
import '../../features/template/presentation/pages/template_page.dart';
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
        // route pour la page d'accueil
        StatefulShellBranch(
          routes: [
            GoRoute(path: peerRoute, builder: (context, state) => const PeerPage()),
            GoRoute(path: chatRoute, builder: (context, state) => ChatPage(peer: state.extra as PeerEntity)),
          ],
        ),

        // route pour la page de recherche
        StatefulShellBranch(routes: [GoRoute(path: connectionRoute, builder: (context, state) => const TemplatePage())]),

        // route pour la page de favoris
        StatefulShellBranch(routes: [GoRoute(path: contactRoute, builder: (context, state) => const TemplatePage())]),

        // route pour la page de compte
        StatefulShellBranch(routes: [GoRoute(path: demandeRoute, builder: (context, state) => const TemplatePage())]),
      ],
    ),

    // autre
    GoRoute(path: homeRoute, builder: (context, state) => const TemplatePage()),
  ],
);
