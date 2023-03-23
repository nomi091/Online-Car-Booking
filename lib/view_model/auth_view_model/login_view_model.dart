// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:online_booking/reposotory/auth_repo/login_repo.dart';
import 'package:online_booking/utils/constants/utils_message.dart';
import 'package:online_booking/utils/routes/routes.dart';
import 'package:online_booking/view_model/user_view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart/user_model.dart';


class LoginViewModel with ChangeNotifier {
  bool _loginloading = false;
  bool? success;
  String? message;
  String? token;

  bool get loginloading => _loginloading;

  setLoading(bool value) {
    _loginloading = value;
    notifyListeners();
  }



  final _myrepo = LoginRepository();
  Future<void> loginApi({dynamic data, BuildContext? context}) async {
    final userPrefernces = Provider.of<UserViewModel>(context!, listen: false);
    setLoading(true);
    _myrepo
        .loginApi(
      data,
    )
        .then((value) {
      {
        setLoading(false);

        if (value['error'] == false) {
          userPrefernces.saveUser(
            UserModel(
              token: value['user']['token'].toString(),
            ),
          );
          
          Navigator.pushNamedAndRemoveUntil(
            context,
            ScreenRoutes.viewCar,
            (route) => false,
          );
        } else {
          Utils.toastMessage(message: value['message']);
        }
      }
    }).onError((error, stackTrace) {
      {
        setLoading(false);
        Utils.toastMessage(message: error.toString());
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }
}
