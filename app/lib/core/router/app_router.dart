import 'package:go_router/go_router.dart';
import 'package:recom24/features/auth/screens/splash_screen.dart';
import 'package:recom24/features/auth/screens/login_screen.dart';
import 'package:recom24/features/auth/screens/register_screen.dart';
import 'package:recom24/features/home/screens/home_screen.dart';
import 'package:recom24/features/analytics/screens/analytics_screen.dart';
import 'package:recom24/features/learn/screens/learn_screen.dart';
import 'package:recom24/features/chat/screens/chat_screen.dart';
import 'package:recom24/features/profile/screens/profile_screen.dart';
import 'package:recom24/features/profile/screens/profile_edit_screen.dart';
import 'package:recom24/features/notifications/screens/notifications_screen.dart';
import 'package:recom24/features/loyalty/screens/loyalty_screen.dart';
import 'package:recom24/features/shell/shell_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const analytics = '/analytics';
  static const learn = '/learn';
  static const chat = '/chat';
  static const profile = '/profile';
  static const profileEdit = '/profile/edit';
  static const notifications = '/notifications';
  static const loyalty = '/loyalty';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: AppRoutes.loyalty,
      builder: (context, state) => const LoyaltyScreen(),
    ),
    GoRoute(
      path: AppRoutes.profileEdit,
      builder: (context, state) => const ProfileEditScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.analytics,
          builder: (context, state) => const AnalyticsScreen(),
        ),
        GoRoute(
          path: AppRoutes.learn,
          builder: (context, state) => const LearnScreen(),
        ),
        GoRoute(
          path: AppRoutes.chat,
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
