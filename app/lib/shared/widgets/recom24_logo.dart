import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';

/// The "24 / RECOM24" logo widget used on splash and login screens
class Recom24Logo extends StatelessWidget {
  final double size;

  const Recom24Logo({super.key, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        // White rounded square card
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size * 0.22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '24',
            style: GoogleFonts.inter(
              fontSize: size * 0.46,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
        // RECOM24 pill label
        Positioned(
          bottom: -(size * 0.14),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size * 0.18, vertical: size * 0.06),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(size * 0.12),
            ),
            child: Text(
              'RECOM24',
              style: GoogleFonts.inter(
                fontSize: size * 0.14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
