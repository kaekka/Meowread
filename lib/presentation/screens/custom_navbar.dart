import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onScanTap;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onScanTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.all(16), // Floating style
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.primary, // Use primary color from theme
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(context, Icons.grid_view, 0),
            _navItem(context, Icons.coffee, 1),

            // Scan Button
            GestureDetector(
              onTap: onScanTap,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.background, // Use background color from theme
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 30,
                  color: colorScheme.primary, // Use primary color
                ),
              ),
            ),

            _navItem(context, Icons.pets, 2),
            _navItem(context, Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, int index) {
    final bool isSelected = currentIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    // Color for icons on the primary-colored navbar
    final Color iconColor = colorScheme.onPrimary;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 3,
            width: isSelected ? 20 : 0,
            margin: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              color: iconColor, // Use onPrimary color
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 1, end: isSelected ? 1.2 : 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Icon(
                  icon,
                  size: 28,
                  color: isSelected ? iconColor : iconColor.withOpacity(0.7), // Use onPrimary color
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
