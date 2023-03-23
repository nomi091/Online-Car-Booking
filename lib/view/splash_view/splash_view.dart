import 'package:flutter/material.dart';
import 'package:online_booking/utils/constants/constants-width.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants/color.dart';
import '../../utils/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  int splashtime = 5;
  // duration of splash screen on second
  @override
  void initState() {
    // Delaying the screen for the specified time before navigating
    // to the next screen
    Future.delayed(Duration(seconds: splashtime), () async {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      var token = pref.getString('token');
      print('token $token');
      // Checking if the user has a token, if not, navigate to login screen,
      // otherwise navigate to home screen
      token != null
          // ignore: use_build_context_synchronously
          ? Navigator.pushNamedAndRemoveUntil(
              context, ScreenRoutes.viewCar, (route) => false)
          // ignore: use_build_context_synchronously
          : Navigator.pushNamedAndRemoveUntil(
              context, ScreenRoutes.login, (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              //vertically align center
              children: [
                SizedBox(
                    height: Constants.getHeight(context),
                    width: Constants.getWidth(context),
                    child: Image.asset('assets/car.jpeg')),
                CircularProgressIndicator(
                  color: AppColor.buttonColor,
                )
              ])),
    ));
  }
}
