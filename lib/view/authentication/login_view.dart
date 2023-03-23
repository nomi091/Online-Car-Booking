import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:online_booking/utils/constants/color.dart';
import 'package:online_booking/utils/constants/constants-width.dart';
import 'package:online_booking/utils/routes/routes.dart';
import 'package:online_booking/view_model/auth_view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../utils/constants/circular_progress_indecator.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

// Define TextEditingController for email and password fields
final myControllerEmail = TextEditingController();
final myControllerPassword = TextEditingController();

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    // Implement dispose method to clean up controller when widget is disposed
    @override
    void dispose() {
      myControllerEmail.dispose();
      myControllerPassword.dispose();
      super.dispose();
    }

    // Define a method for validating email and password input
    bool validData() {
      if (!isEmail(myControllerEmail.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter Valid Email Address"),
          duration: Duration(seconds: 1),
        ));
        return false;
      }

      if (myControllerPassword.text.isNotEmpty &&
          myControllerPassword.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Enter Valid Password"),
          duration: Duration(seconds: 1),
        ));
        return false;
      }
      return true;
    }

    // Build the UI for LoginView
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.6),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Constants.getHeight(context),
            child: Stack(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets.bottom > 0
                            ? const EdgeInsets.only(top: 90)
                            : const EdgeInsets.only(top: 150),
                        child: Column(
                          children: [
                            SizedBox(
                              width: Constants.getWidth(context) * .9,
                              height: Constants.getHeight(context) * 0.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(.8),
                                    ),
                                  ),
                                  // Create component for email field with icon and hint text
                                  component(
                                    icon: Icons.email_outlined,
                                    hintText: 'Email...',
                                    isPassword: false,
                                    isEmail: true,
                                    textediting: myControllerEmail,
                                  ),
                                  // Create component for password field with icon and hint text
                                  component(
                                      icon: Icons.lock_outline,
                                      hintText: 'Password...',
                                      isEmail: false,
                                      isPassword: true,
                                      textediting: myControllerPassword),
                                  Column(
                                    children: [
                                      //login button used to login user
                                      Consumer<LoginViewModel>(
                                          builder: (context, value, child) {
                                        return InkWell(
                                          onTap: () {
                                            if (validData() == true) {
                                              Map data = {
                                                'email': myControllerEmail.text,
                                                'password':
                                                    myControllerPassword.text,
                                              };
                                              if (value.loginloading == false) {
                                                value.loginApi(
                                                    data: data,
                                                    context: context);
                                              }
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom:
                                                  Constants.getWidth(context) *
                                                      .05,
                                            ),
                                            height:
                                                Constants.getHeight(context)*0.06
                                                    ,
                                            width: Constants.getWidth(context) /
                                                1.25,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColor.buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: value.loginloading == true
                                                ? ProgressIndecator
                                                    .loadingIndecator()
                                                : const Text(
                                                    'Log In',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                          ),
                                        );
                                      }),
                                      // text widget used to route user on registration
                                      RichText(
                                        text: TextSpan(
                                          text: 'Create a new Account',
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.white,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                context,
                                                ScreenRoutes.singup,
                                              );
                                            },
                                        ),
                                      ),
                                    ],
                                  ),

                                  //  SizedBox(height: size.width * .2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// custom text field
  Widget component({icon, hintText, isPassword, isEmail, textediting}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: textediting,
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),
        //  controller: textediting,
        // obscureText: _passwordVisible,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          //  suffixIcon: IconButton(
          //   icon: Icon(
          //     // Based on passwordVisible state choose the icon
          //     _passwordVisible ? Icons.visibility : Icons.visibility_off,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     // Update the state i.e. toogle the state of passwordVisible variable
          //     setState(() {
          //       _passwordVisible = !_passwordVisible;
          //     });
          //   },
          // ),
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
