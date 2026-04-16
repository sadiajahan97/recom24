import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/features/learn/widgets/learn_content_card.dart';
import 'package:recom24/shared/widgets/recom_app_bar.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RecomAppBar(title: 'Learn', showBack: false),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Curated For You',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Growth pathways selected by Recom AI',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'View All\nPrograms',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList.separated(
              itemCount: _contents.length,
              separatorBuilder: (_, _) => const SizedBox(height: 20),
              itemBuilder: (context, i) {
                return LearnContentCard(content: _contents[i])
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 200 + i * 100),
                      duration: 400.ms,
                    )
                    .slideY(begin: 0.05, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  static final _contents = [
    _LearnCardData(
      type: 'SEMINAR',
      duration: '45 MINS',
      title: 'Architecting Leadership Flow',
      subtitle: 'Master the art of editorial management.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1A2A3A), Color(0xFF2C4A6A)],
      ),
      typeColor: AppColors.primary,
    ),
    _LearnCardData(
      type: 'INTENSIVE',
      duration: '2 HOURS',
      title: 'Global Strategy Networks',
      subtitle: 'Expand your professional influence.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0A1628), Color(0xFF0D2540)],
      ),
      typeColor: Colors.deepOrange,
    ),
    _LearnCardData(
      type: 'WORKSHOP',
      duration: '30 MINS',
      title: 'Executive Communication',
      subtitle: 'Hone your leadership communication style.',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1E1A3A), Color(0xFF2C2260)],
      ),
      typeColor: AppColors.success,
    ),
  ];
}

class _LearnCardData {
  final String type;
  final String duration;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final Color typeColor;

  const _LearnCardData({
    required this.type,
    required this.duration,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.typeColor,
  });
}
