import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';

/// The common app bar used across all inner screens
class RecomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final bool showLanguageToggle;
  final bool showAiAvatar;
  final bool showNotification;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAiTap;

  const RecomAppBar({
    super.key,
    this.title,
    this.showBack = false,
    this.showLanguageToggle = true,
    this.showAiAvatar = true,
    this.showNotification = true,
    this.onNotificationTap,
    this.onAiTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            )
          : _buildLogoTitle(),
      titleSpacing: 16,
      actions: [
        if (showLanguageToggle) const _LanguageToggle(),
        if (showAiAvatar) _AiAvatarButton(onTap: onAiTap),
        if (showNotification)
          _NotificationButton(onTap: onNotificationTap),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildLogoTitle() {
    return Text(
      'Recom24',
      style: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      ),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Text('EN',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
          const SizedBox(width: 6),
          Text('BN',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _AiAvatarButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _AiAvatarButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.smart_toy_rounded,
            color: Colors.white, size: 20),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _NotificationButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: const Icon(Icons.notifications_outlined,
            color: AppColors.textPrimary, size: 20),
      ),
    );
  }
}
