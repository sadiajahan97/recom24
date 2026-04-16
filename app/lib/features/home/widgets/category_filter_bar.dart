import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/models/models.dart';
import 'package:recom24/core/theme/app_theme.dart';

class CategoryFilterBar extends StatelessWidget {
  final RecommendationCategory selected;
  final ValueChanged<RecommendationCategory> onChanged;

  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      (RecommendationCategory.all, 'All Actions'),
      (RecommendationCategory.strategy, 'Strategy'),
      (RecommendationCategory.networking, 'Networking'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: categories.map((item) {
          final (cat, label) = item;
          final isSelected = selected == cat;
          return GestureDetector(
            onTap: () => onChanged(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
