import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/router/app_router.dart';
import 'package:recom24/core/theme/app_theme.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;

  const ShellScreen({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return switch (location) {
      _ when location.startsWith(AppRoutes.home) => 0,
      _ when location.startsWith(AppRoutes.analytics) => 1,
      _ when location.startsWith(AppRoutes.learn) => 2,
      _ when location.startsWith(AppRoutes.chat) => 3,
      _ when location.startsWith(AppRoutes.profile) => 4,
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final idx = _currentIndex(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: child,
      bottomNavigationBar: _BottomNavBar(currentIndex: idx),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const _BottomNavBar({required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
      case 1:
        context.go(AppRoutes.analytics);
      case 2:
        context.go(AppRoutes.learn);
      case 3:
        context.go(AppRoutes.chat);
      case 4:
        context.go(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.calendar_today_outlined, label: 'TODAY'),
      _NavItem(icon: Icons.bar_chart_outlined, label: 'ANALYTICS'),
      _NavItem(icon: Icons.menu_book_outlined, label: 'LEARN'),
      _NavItem(icon: Icons.smart_toy_outlined, label: 'RECOM AI'),
      _NavItem(icon: Icons.person_outline, label: 'PROFILE'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final selected = i == currentIndex;
              return GestureDetector(
                onTap: () => _onTap(context, i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 22,
                        color: selected
                            ? AppColors.primary
                            : AppColors.textHint,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: selected
                              ? AppColors.primary
                              : AppColors.textHint,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem({required this.icon, required this.label});
}
