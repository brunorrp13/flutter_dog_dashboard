import 'package:flutter/material.dart';

class IotToggleButton extends StatelessWidget {
  const IotToggleButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onToggle,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onToggle,
      icon: Icon(icon, color: isActive ? Colors.white : null),
      label:
          Text(label, style: TextStyle(color: isActive ? Colors.white : null)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey[200],
        foregroundColor: isActive ? Colors.white : Colors.black,
        minimumSize: const Size(140, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
