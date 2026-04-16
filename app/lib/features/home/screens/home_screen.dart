import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/models/models.dart';
import 'package:recom24/core/router/app_router.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/features/home/widgets/category_filter_bar.dart';
import 'package:recom24/features/home/widgets/recommendation_card.dart';
import 'package:recom24/shared/widgets/recom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecommendationCategory _selectedCategory = RecommendationCategory.all;

  final _recommendations = [
    Recommendation(
      index: 1,
      title: 'Master CSS Grid in 15 Minutes',
      status: RecommendationStatus.urgent,
      category: 'SKILL',
      durationMinutes: 15,
      difficulty: 'Hard',
      isCompleted: true,
    ),
    Recommendation(
      index: 2,
      title: 'Morning Mobility Protocol',
      status: RecommendationStatus.newItem,
      category: 'HEALTH',
      durationMinutes: 15,
      difficulty: 'Relaxing',
      isCompleted: true,
    ),
    Recommendation(
      index: 3,
      title: 'Morning Mobility Protocol',
      status: RecommendationStatus.newItem,
      category: 'HEALTH',
      durationMinutes: 15,
      difficulty: 'Relaxing',
      isCompleted: false,
    ),
    Recommendation(
      index: 4,
      title: 'Strategic Networking Lunch',
      status: RecommendationStatus.regular,
      category: 'NETWORKING',
      durationMinutes: 60,
      difficulty: 'Moderate',
      isCompleted: false,
    ),
    Recommendation(
      index: 5,
      title: 'Deep Work Session: Q4 Planning',
      status: RecommendationStatus.regular,
      category: 'STRATEGY',
      durationMinutes: 90,
      difficulty: 'Focused',
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RecomAppBar(
        onNotificationTap: () => context.push(AppRoutes.notifications),
        onAiTap: () => context.go(AppRoutes.chat),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Next refresh badge
                _RefreshBadge()
                    .animate()
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: 12),
                // Today's 24 header
                _TodayHeader()
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 400.ms),
                const SizedBox(height: 24),
                // Category filter
                CategoryFilterBar(
                  selected: _selectedCategory,
                  onChanged: (c) => setState(() => _selectedCategory = c),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Top 5 Recommendations',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList.separated(
              itemCount: _recommendations.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                return RecommendationCard(
                  recommendation: _recommendations[i],
                  onCheckChanged: (val) => setState(() {}),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 300 + i * 80),
                      duration: 400.ms,
                    )
                    .slideX(begin: 0.05, end: 0);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _RefreshBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.refresh_rounded,
              size: 13, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            'NEXT REFRESH IN 14:22:09',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Today's 24",
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your curated selection of growth\nopportunities for the next 24 hours.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
