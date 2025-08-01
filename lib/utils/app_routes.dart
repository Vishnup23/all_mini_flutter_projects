import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../activation/login.dart';
import '../activation/splash_screen.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const Login()),
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return Scaffold(
    //       body: child,
    //       bottomNavigationBar: BottomNavigationBar(
    //         currentIndex: _calculateIndex(state.location),
    //         onTap: (index) {
    //           switch (index) {
    //             case 0:
    //               context.go('/dashboard');
    //               break;
    //             case 1:
    //               context.go('/settings');
    //               break;
    //           }
    //         },
    //         items: const [
    //           BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
    //           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
    //         ],
    //       ),
    //     );
    //   },
    //   routes: [
    //     GoRoute(
    //       path: '/dashboard',
    //       builder: (context, state) => const DashboardScreen(),
    //     ),
    //     GoRoute(
    //       path: '/settings',
    //       builder: (context, state) => const SettingsScreen(),
    //     ),
    //   ],
    // ),
  ],
 // errorBuilder: (context, state) => const ErrorPage(),
);

int _calculateIndex(String location) {
  if (location.startsWith('/settings')) return 1;
  return 0;
}
