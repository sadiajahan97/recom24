import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/shared/widgets/recom_app_bar.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const RecomAppBar(title: 'Analytics', showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Performance streak card
            _PerformanceStreakCard()
                .animate()
                .fadeIn(duration: 400.ms),
            const SizedBox(height: 24),
            Text(
              'Suggestion Breakdown',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 14),
            ...[
              _BreakdownItem(
                icon: Icons.work_outline_rounded,
                iconColor: AppColors.primary,
                label: 'Career Development',
                count: 6,
                isHighlight: false,
              ),
              _BreakdownItem(
                icon: Icons.psychology_outlined,
                iconColor: Colors.orange,
                label: 'Skill Acquisition',
                count: 8,
                isHighlight: false,
              ),
              _BreakdownItem(
                icon: Icons.favorite_outline_rounded,
                iconColor: AppColors.success,
                label: 'Personal Wellbeing',
                count: 4,
                isHighlight: true,
              ),
            ]
                .asMap()
                .entries
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: e.value
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 300 + e.key * 100),
                            duration: 400.ms,
                          )
                          .slideX(begin: 0.05, end: 0),
                    ))
                ,
          ],
        ),
      ),
    );
  }
}

class _PerformanceStreakCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final values = [0.35, 0.45, 0.4, 0.55, 0.8, 0.75, 0.9];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance\nStreak',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your consistent growth over the last 7 days',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  'Current:\n12 Days',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 1.0,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            days[value.toInt()],
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: List.generate(days.length, (i) {
                  final isCurrent = i >= 4;
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: values[i],
                        color: isCurrent
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.25),
                        width: 28,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8)),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int count;
  final bool isHighlight;

  const _BreakdownItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.count,
    required this.isHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (isHighlight)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count Items',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            )
          else
            Text(
              '$count Items',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}
