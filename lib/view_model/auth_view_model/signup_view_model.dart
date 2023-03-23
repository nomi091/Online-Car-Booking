// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:online_booking/model/user_model.dart/user_model.dart';
import 'package:online_booking/reposotory/auth_repo/signup_repo.dart';
import 'package:online_booking/utils/constants/utils_message.dart';
import 'package:online_booking/utils/routes/routes.dart';
import 'package:online_booking/view_model/user_view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class SignUpViewModel with ChangeNotifier {
  bool _signuploading = false;

  bool? success;
  String? message;
  String? token;

  bool get signuploading => _signuploading;

  setLoading(bool value) {
    _signuploading = value;
    notifyListeners();
  }

  final _myrepo = SignUpRepo();

  Future<void> signUpApi({dynamic data, BuildContext? context}) async {
    final userPrefernces = Provider.of<UserViewModel>(context!, listen: false);

    setLoading(true);
    _myrepo
        .signUpApi(
      data,
    )
        .then((value) {
      {
        setLoading(false);

        if (kDebugMode) {
          print(value.toString());
        }

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
