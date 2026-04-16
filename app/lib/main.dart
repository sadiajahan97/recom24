import 'package:flutter/material.dart';
import 'package:recom24/core/router/app_router.dart';
import 'package:recom24/core/theme/app_theme.dart';

void main() {
  runApp(const Recom24App());
}

class Recom24App extends StatelessWidget {
  const Recom24App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recom24',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
