import 'package:go_router/go_router.dart';
import 'package:samriddhi_algo_trade_app/features/auth/screens/login_screen.dart';
import 'package:samriddhi_algo_trade_app/features/auth/screens/onboarding_screen.dart';
import 'package:samriddhi_algo_trade_app/features/auth/screens/otp_screen.dart';
import 'package:samriddhi_algo_trade_app/features/auth/screens/signup_screen.dart';
import 'package:samriddhi_algo_trade_app/features/auth/screens/splash_screen.dart';
import 'package:samriddhi_algo_trade_app/features/dashboard/home_shell.dart';
import 'package:samriddhi_algo_trade_app/features/profile/connect_broker_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/portfolio/portfolio_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/strategies/strategies_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String otp = '/otp';
  static const String brokerConnect = '/broker-connect';
  static const String home = '/home';
  static const String portfolio = '/portfolio';
  static const String strategies = '/strategies';
  static const String strategyDetail = '/strategies/:id';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String about = '/about';
  static const String notifications = '/notifications';
}

final route = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(path: AppRoutes.login, builder: (context, state) => LoginScreen()),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.brokerConnect,
      builder: (context, state) => BrokerConnectScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return OtpScreen(args: args);
      },
    ),
    ShellRoute(
      builder: (context, state, child) => HomeShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (_, _) => const DashboardScreen(),
        ),
        GoRoute(
          path: AppRoutes.portfolio,
          builder: (_, _) => const PortfolioScreen(),
        ),
        GoRoute(
          path: AppRoutes.strategies,
          builder: (_, _) => const StrategiesScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (_, _) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
