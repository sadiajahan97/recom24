import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/models/models.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/shared/widgets/status_badge.dart';

class RecommendationCard extends StatefulWidget {
  final Recommendation recommendation;
  final ValueChanged<bool?>? onCheckChanged;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    this.onCheckChanged,
  });

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.recommendation.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final rec = widget.recommendation;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Index number
          SizedBox(
            width: 32,
            child: Text(
              rec.index.toString().padLeft(2, '0'),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.border,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badges row
                Row(
                  children: [
                    if (rec.status == RecommendationStatus.urgent)
                      StatusBadge.urgent()
                    else if (rec.status == RecommendationStatus.newItem)
                      StatusBadge.newBadge(),
                    const SizedBox(width: 6),
                    StatusBadge.category(rec.category),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rec.title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    InfoChip(
                      icon: Icons.access_time_outlined,
                      label: '${rec.durationMinutes}m',
                    ),
                    const SizedBox(width: 12),
                    InfoChip(
                      icon: _difficultyIcon(rec.difficulty),
                      label: rec.difficulty,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Action area
          Column(
            children: [
              // Play/Arrow button
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: rec.status == RecommendationStatus.urgent
                      ? AppColors.primary
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(
                  rec.status == RecommendationStatus.urgent
                      ? Icons.arrow_forward_ios_rounded
                      : Icons.play_arrow_rounded,
                  color: rec.status == RecommendationStatus.urgent
                      ? Colors.white
                      : AppColors.textSecondary,
                  size: 16,
                ),
              ),
              const SizedBox(height: 8),
              // Checkbox
              GestureDetector(
                onTap: () {
                  setState(() => _isCompleted = !_isCompleted);
                  widget.onCheckChanged?.call(_isCompleted);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _isCompleted
                        ? AppColors.success
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _isCompleted
                          ? AppColors.success
                          : AppColors.border,
                      width: 1.5,
                    ),
                  ),
                  child: _isCompleted
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _difficultyIcon(String difficulty) {
    return switch (difficulty.toLowerCase()) {
      'hard' || 'intense' || 'focused' => Icons.trending_up_rounded,
      'relaxing' || 'easy' => Icons.self_improvement_outlined,
      _ => Icons.radio_button_unchecked,
    };
  }
}
