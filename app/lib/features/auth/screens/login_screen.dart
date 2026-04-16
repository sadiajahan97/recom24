import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/router/app_router.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/shared/widgets/app_text_field.dart';
import 'package:recom24/shared/widgets/primary_button.dart';
import 'package:recom24/shared/widgets/recom24_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // API integration will be added later
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo
                const Recom24Logo(size: 110)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: -0.2),
                const SizedBox(height: 40),
                // Name field
                AppTextField(
                  label: 'Name',
                  controller: _nameController,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                const SizedBox(height: 14),
                // Password field
                PasswordTextField(
                  label: 'Password',
                  controller: _passwordController,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                const SizedBox(height: 10),
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                const SizedBox(height: 24),
                // Login button
                PrimaryButton(
                  label: 'Login',
                  trailingIcon: Icons.arrow_forward,
                  onPressed: _onLogin,
                ).animate().fadeIn(delay: 450.ms, duration: 500.ms),
                const SizedBox(height: 28),
                // OR divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'Or',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textHint,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.border)),
                  ],
                ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
                const SizedBox(height: 16),
                // Apple login
                OutlinedSocialButton(
                  label: 'Login with Apple',
                  leading: const Icon(Icons.apple, size: 22),
                  onPressed: () {},
                ).animate().fadeIn(delay: 550.ms, duration: 500.ms),
                const SizedBox(height: 12),
                // Google login
                OutlinedSocialButton(
                  label: 'Login with Google',
                  leading: _GoogleIcon(),
                  onPressed: () {},
                ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
                const SizedBox(height: 32),
                // Sign up
                GestureDetector(
                  onTap: () => context.go(AppRoutes.register),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: GoogleFonts.inter(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 650.ms, duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final colors = [
      const Color(0xFF4285F4),
      const Color(0xFF34A853),
      const Color(0xFFFBBC05),
      const Color(0xFFEA4335),
    ];

    final sweeps = [90.0, 90.0, 90.0, 90.0];
    final starts = [-90.0, 0.0, 90.0, 180.0];

    for (int i = 0; i < 4; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.7),
        _toRad(starts[i]),
        _toRad(sweeps[i]),
        false,
        paint,
      );
    }
  }

  double _toRad(double deg) => deg * 3.14159265 / 180;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
