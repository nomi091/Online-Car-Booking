import 'package:flutter/material.dart';
import 'package:online_booking/utils/routes/custom_page_route.dart';
import 'package:online_booking/view/authentication/signup_view.dart';
import 'package:online_booking/view/home_view/car_view.dart';
import 'package:online_booking/view/splash_view/splash_view.dart';

import '../../view/authentication/login_view.dart';
import '../../view/home_view/add_car_view.dart';

class ScreenRoutes {
  static const String splash = "splash";
  static const String login = "login";
  static const String singup = "signup";
  static const String addCar = "addCar";
  static const String viewCar = "viewAllCar";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      /// WalkThrough FLOW
      /// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      // case splash:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const SplashScreen(),
      //   );
      case splash:
        return CustomPageRoute(
          child: const SplashScreen(),
        );
      case login:
        return CustomPageRoute(
          child: const LoginView(),
        );
      case singup:
        return CustomPageRoute(
          child: const SignupScreen(),
        );
      case addCar:
        return CustomPageRoute(
          child: const AddCarScreen(),
        );
      case viewCar:
        return CustomPageRoute(
          child: const ViewCarScreen(),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
