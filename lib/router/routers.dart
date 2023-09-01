import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/views/aahstar_live/livehome_screen.dart';
import 'package:aahstar/views/auth/forgot_password_screen.dart';
import 'package:aahstar/views/auth/login_screen.dart';
import 'package:aahstar/views/auth/sign_up_screen.dart';
import 'package:aahstar/views/content/upload_content_screen.dart';
import 'package:aahstar/views/dashboard/dashboard_screen.dart';
import 'package:aahstar/views/extra/privacy_policy_screen.dart';
import 'package:aahstar/views/extra/terms_and_conditions_screen.dart';
import 'package:aahstar/views/fan/payment/buy_fan_subscription_screen.dart';
import 'package:aahstar/views/home/entertainer_dashboard.dart';
import 'package:aahstar/views/home/home_screen.dart';
import 'package:aahstar/views/profile/edit_profile_screen.dart';
import 'package:aahstar/views/splash/splash_screen.dart';
import 'package:aahstar/views/subscription/buy_subscription_screen.dart';
import 'package:aahstar/views/subscription/althlete_slide_subscription.dart';
import 'package:aahstar/views/subscription/fan_slide_subscription.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      // Auth Routes
      case loginRoute:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case signUpRoute:
        return PageTransition(
          child: const SignUpScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case forgotPasswordRoute:
        return PageTransition(
          child: const ForgotPasswordScreen(),
          type: PageTransitionType.rightToLeft,
        );

      // Main Routes
      case dashboardRoute:
        return PageTransition(
          child: const DashboardScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case entertaineDashboardRoute:
        return PageTransition(
          child: const EntertainerDashboardScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case homedRoute:
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case buySubscriptionRoute:
        return PageTransition(
          child: const BuySubscribtionScreen(),
          type: PageTransitionType.rightToLeft,
        );

      // case buyFansubscriptionRoute:
      //   return PageTransition(
      //     child: const BuyFanSubscriptionScreen(),
      //     type: PageTransitionType.rightToLeft,
      //   );

      case editProfileRoute:
        return PageTransition(
          child: const EditProfileScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case uploadContentRoute:
        return PageTransition(
          child: const UploadContentScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case fanSlideSubscriptionRoute:
        return PageTransition(
          child: const FanSlideSubscriptionScreen(),
          type: PageTransitionType.rightToLeft,
        );
      // Extra Route
      case privacyPolicyRoute:
        return PageTransition(
          child: const PrivacyPolicyScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case termsAndConditionsRoute:
        return PageTransition(
          child: const TermsAndConditionsScreen(),
          type: PageTransitionType.rightToLeft,
        );

      case athleteSubscriptionRoute:
        return PageTransition(
          child: const AthleteSubscriptionScreen(),
          type: PageTransitionType.rightToLeft,
        );

      // case liveRoute:
      //   return PageTransition(
      //     child: LiveScreen(),
      //     type: PageTransitionType.rightToLeft,
      //   );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
