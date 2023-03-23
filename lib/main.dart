import 'package:flutter/material.dart';
import 'package:online_booking/utils/routes/routes.dart';
import 'package:online_booking/view_model/car_view_model/car_view_model.dart';
import 'package:provider/provider.dart';

import 'view_model/auth_view_model/login_view_model.dart';
import 'view_model/auth_view_model/signup_view_model.dart';
import 'view_model/user_view_model/user_view_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => CarViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: const MaterialApp(
        initialRoute: ScreenRoutes.splash,
        onGenerateRoute: ScreenRoutes.generateRoute,
      ),
    );
  }
}
