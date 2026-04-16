import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/theme/app_theme.dart';

class LearnContentCard extends StatelessWidget {
  final dynamic content;

  const LearnContentCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image/gradient card
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: content.gradient as LinearGradient,
            ),
            child: Stack(
              children: [
                // Decorative network lines (abstract pattern)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _NetworkPatternPainter(),
                  ),
                ),
                // Bottom badges overlay
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Row(
                    children: [
                      _TypeBadge(
                        label: content.type as String,
                        color: content.typeColor as Color,
                      ),
                      const SizedBox(width: 8),
                      _TypeBadge(
                        label: content.duration as String,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content.title as String,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content.subtitle as String,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _TypeBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _NetworkPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw some abstract connecting lines
    final points = [
      Offset(size.width * 0.3, size.height * 0.2),
      Offset(size.width * 0.6, size.height * 0.35),
      Offset(size.width * 0.8, size.height * 0.25),
      Offset(size.width * 0.5, size.height * 0.5),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.7, size.height * 0.65),
    ];

    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        canvas.drawLine(points[i], points[j], paint);
      }
      canvas.drawCircle(
          points[i], 3, paint..style = PaintingStyle.fill);
      paint.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
