import 'package:flutter/material.dart';

import '../../utils/generator_utils.dart';

class QRTypeCard extends StatelessWidget {
  final QRType type;
  final bool selected;
  final VoidCallback onTap;

  const QRTypeCard({
    super.key,
    required this.type,
    required this.selected,
    required this.onTap,
  });

  IconData get icon {
    switch (type) {
      case QRType.text:
        return Icons.text_fields;
      case QRType.url:
        return Icons.link;
      case QRType.email:
        return Icons.email;
      case QRType.phone:
        return Icons.phone;
      case QRType.sms:
        return Icons.sms;
      case QRType.wifi:
        return Icons.wifi;
      case QRType.geo:
        return Icons.location_on;
      case QRType.contact:
        return Icons.contacts;
      case QRType.event:
        return Icons.event;
    }
  }

  String get label => type.name.toUpperCase();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: selected ? Theme.of(context).primaryColor : colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.all(12),
          width: 100,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: selected ? Colors.white : colorScheme.onSurface,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
