import 'package:flutter/material.dart';
import '../../domain/entities/message_entity.dart';

class CustomSnackBar extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback onDismiss;

  const CustomSnackBar({super.key, required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(message.id),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDismiss(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .1), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.blue.withValues(alpha: .1), borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.message, color: Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Nouveau message', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(message.content, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.close, size: 20), onPressed: onDismiss),
          ],
        ),
      ),
    );
  }
}
