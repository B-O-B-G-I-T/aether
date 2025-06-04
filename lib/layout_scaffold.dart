// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/chat/presentation/widgets/notification_preview.dart';
import 'features/chat/presentation/widgets/notification_manager.dart';

class LayoutScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const LayoutScaffold({Key? key, required this.navigationShell}) : super(key: key ?? const ValueKey<String>('LayoutScaffold'));
  final selectedColor = Colors.black;
  final unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return NotificationManager(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: navigationShell,
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2, offset: Offset(0, -2))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, 'Accueil', Icons.home),
              _buildNavItem(1, 'Peer Meet', Icons.wifi_tethering),
              // _buildNavItem(2, 'Panier', 'assets/icon_bottombar/shopping-bag.svg', context: context),
              _buildNavItem(2, 'Favoris', Icons.favorite),
              _buildNavItem(3, 'Compte', Icons.person),
            ],
          ),
        ),
        appBar: AppBar(title: const Text('Aether'), actions: const [NotificationPreview(), SizedBox(width: 16)]),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String label,
    IconData icon,
    /*{BuildContext? context}*/
  ) {
    bool isSelected = navigationShell.currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // if (context != null) {
          //   context.read<CartBloc>().add(LoadCartEvent());
          // }
          navigationShell.goBranch(index);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 0),
          padding: EdgeInsets.symmetric(vertical: 17.5),
          decoration: BoxDecoration(color: isSelected ? Colors.blue : Colors.transparent),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isSelected ? icon : icon, color: isSelected ? selectedColor : unselectedColor),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Destination {
  final String title;
  final IconData icon;

  const Destination({required this.title, required this.icon});
}
