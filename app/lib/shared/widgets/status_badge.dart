import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';

/// A chip badge (e.g. URGENT, NEW, SKILL, HEALTH)
class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.textColor = Colors.white,
  });

  factory StatusBadge.urgent() => const StatusBadge(
        label: 'URGENT',
        backgroundColor: AppColors.urgent,
      );

  factory StatusBadge.newBadge() => const StatusBadge(
        label: 'NEW',
        backgroundColor: AppColors.primary,
      );

  factory StatusBadge.category(String label) => StatusBadge(
        label: label,
        backgroundColor: AppColors.surfaceVariant,
        textColor: AppColors.textSecondary,
      );

  factory StatusBadge.seminar() => const StatusBadge(
        label: 'SEMINAR',
        backgroundColor: AppColors.primary,
      );

  factory StatusBadge.intensive() => StatusBadge(
        label: 'INTENSIVE',
        backgroundColor: Colors.orange.shade700,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// A small info chip with icon (e.g. "15m", "Hard", "Relaxing")
class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoChip({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.textSecondary),
        const SizedBox(width: 3),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
