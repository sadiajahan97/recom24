import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recom24/core/router/app_router.dart';
import 'package:recom24/core/theme/app_theme.dart';
import 'package:recom24/shared/widgets/app_text_field.dart';
import 'package:recom24/shared/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onCreate() {
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
                AppTextField(
                  label: 'Name',
                  controller: _nameController,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
                const SizedBox(height: 14),
                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Required' : null,
                ).animate().fadeIn(delay: 150.ms, duration: 500.ms),
                const SizedBox(height: 14),
                AppTextField(
                  label: 'Phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
                const SizedBox(height: 14),
                PasswordTextField(
                  label: 'Password',
                  controller: _passwordController,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Min 6 chars' : null,
                ).animate().fadeIn(delay: 250.ms, duration: 500.ms),
                const SizedBox(height: 14),
                PasswordTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  validator: (v) => v != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                const SizedBox(height: 28),
                PrimaryButton(
                  label: 'Create Account',
                  trailingIcon: Icons.arrow_forward,
                  onPressed: _onCreate,
                ).animate().fadeIn(delay: 350.ms, duration: 500.ms),
                const SizedBox(height: 24),
                // Encrypted session notice
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shield_outlined,
                            color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ENCRYPTED SESSION',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Secure enterprise-grade encryption enabled. Your access is being logged for institutional compliance and security auditing.',
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
                ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
                const SizedBox(height: 28),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.login),
                  child: RichText(
                    text: TextSpan(
                      text: 'You have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: GoogleFonts.inter(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 450.ms, duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
