import 'package:flutter/material.dart';
import 'package:sensotech/constants/theme.dart';

class EmptyList extends StatelessWidget {
  final VoidCallback? onReload;
  final IconData icon;
  final String title, subtitle;

  const EmptyList(
      {super.key,
      this.onReload,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Illustration or Icon
            Icon(
              icon,
              size: 70,
              color: kPrimaryColor,
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Subtitle
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: kTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
