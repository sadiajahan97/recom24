import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/shared/widgets/recom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RecomAppBar(
        title: 'Notifications',
        showBack: true,
        onNotificationTap: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _NotificationGroup(title: 'SUGGESTIONS', items: _suggestions)
              .animate()
              .fadeIn(duration: 400.ms),
          const SizedBox(height: 8),
          _NotificationGroup(title: 'MILESTONES', items: _milestones)
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms),
          const SizedBox(height: 8),
          _NotificationGroup(title: 'SYSTEM UPDATES', items: _systemUpdates)
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms),
        ],
      ),
    );
  }

  static final _suggestions = [
    _NotifData(
      icon: Icons.lightbulb_outline_rounded,
      iconColor: AppColors.primary,
      title: 'New Growth Path Identified',
      body:
          'Based on your recent activity, we\'ve unlocked the "Advanced Management Strategy" module for you.',
      time: 'JUST NOW',
      isHighlighted: true,
    ),
    _NotifData(
      icon: Icons.people_outline_rounded,
      iconColor: AppColors.textSecondary,
      title: 'Connect with Mentors',
      body:
          'Three industry experts in Finance are available for a coffee chat this week.',
      time: '2H AGO',
    ),
  ];

  static final _milestones = [
    _NotifData(
      icon: Icons.emoji_events_outlined,
      iconColor: AppColors.warning,
      title: 'Level 24 Explorer Unlocked',
      body:
          'Congratulations! You\'ve reached the Executive Plan baseline. Your influence score increased by 15%.',
      time: 'YESTERDAY',
    ),
  ];

  static final _systemUpdates = [
    _NotifData(
      icon: Icons.settings_outlined,
      iconColor: AppColors.textSecondary,
      title: 'Privacy Policy Update',
      body:
          'We\'ve updated our data handling protocols to better protect your professional insights.',
      time: '2 DAYS AGO',
    ),
    _NotifData(
      icon: Icons.info_outline_rounded,
      iconColor: AppColors.textSecondary,
      title: 'Scheduled Maintenance',
      body:
          'The platform will undergo brief maintenance on Sunday from 2:00–3:00 AM.',
      time: '3 DAYS AGO',
    ),
  ];
}

class _NotifData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;
  final String time;
  final bool isHighlighted;

  const _NotifData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.time,
    this.isHighlighted = false,
  });
}

class _NotificationGroup extends StatelessWidget {
  final String title;
  final List<_NotifData> items;

  const _NotificationGroup({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textHint,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _NotificationTile(data: e.value),
                ))
            ,
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final _NotifData data;

  const _NotificationTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: data.isHighlighted ? AppColors.primary : AppColors.border,
          width: data.isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left colored bar for highlighted
          if (data.isHighlighted)
            Container(
              width: 4,
              height: 80,
              margin: const EdgeInsets.only(left: 0),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: data.iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(data.icon, color: data.iconColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.title,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            data.time,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: data.isHighlighted
                                  ? AppColors.primary
                                  : AppColors.textHint,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.body,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
