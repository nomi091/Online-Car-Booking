import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:online_booking/utils/constants/circular_progress_indecator.dart';
import 'package:online_booking/utils/constants/color.dart';
import 'package:online_booking/utils/routes/routes.dart';
import 'package:online_booking/view_model/auth_view_model/signup_view_model.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}
//define texteditingController to get user input data 
final myControllerName = TextEditingController();
final myControllerEmail = TextEditingController();
final myControllerContact = TextEditingController();
final myControllerAddress = TextEditingController();
final myControllerPassword = TextEditingController();

bool isloading = false;

class _SignupScreenState extends State<SignupScreen> {
  final String _singleValue = "";
  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      myControllerName.dispose();
      myControllerEmail.dispose();
      myControllerContact.dispose();
      myControllerAddress.dispose();
      myControllerPassword.dispose();
      super.dispose();
    }
//validation for user enterd data 
    bool validData() {
      if (myControllerName.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Enter Your Name"),
          duration: Duration(seconds: 1),
        ));

        return false;
      }
      if (!isEmail(myControllerEmail.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter Valid Email Address"),
          duration: Duration(seconds: 1),
        ));

        return false;
      }
      if (myControllerContact.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter Phone Number"),
          duration: Duration(seconds: 1),
        ));
        return false;
      }
      if (myControllerAddress.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter Address"),
        ));
        return false;
      }
      if (myControllerPassword.text.isNotEmpty &&
          myControllerPassword.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please Enter Valid Password"),
        ));
        return false;
      }
      return true;
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.6),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Stack(
                  children: [
                   Center(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets.bottom > 0
                            ? const EdgeInsets.only(top: 10)
                            : const EdgeInsets.only(top: 100),
                        // Create component for user fields with icon and hint text
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width * .9,
                              height: size.height * 0.8,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                              255, 255, 255, 255)
                                          .withOpacity(.8),
                                    ),
                                  ),
                                  component(
                                    icon: Icons.person,
                                    hintText: 'Name...',
                                    isPassword: false,
                                    isEmail: false,
                                    textediting: myControllerName,
                                  ),
                                  component(
                                    icon: Icons.email_outlined,
                                    hintText: 'Email...',
                                    isPassword: false,
                                    isEmail: true,
                                    textediting: myControllerEmail,
                                  ),
                                  component(
                                    icon: Icons.phone,
                                    hintText: 'Contact...',
                                    isPassword: false,
                                    isEmail: false,
                                    textediting: myControllerContact,
                                  ),
                                  component(
                                    icon: Icons.location_on_outlined,
                                    hintText: 'Address...',
                                    isPassword: false,
                                    isEmail: false,
                                    textediting: myControllerAddress,
                                  ),
                                  component(
                                      icon: Icons.lock_outline,
                                      hintText: 'Password...',
                                      isEmail: false,
                                      isPassword: true,
                                      textediting: myControllerPassword),
                                      //button is used to signuo user thorugh consumer with signup viewmodel
                                  Column(
                                    children: [
                                      Consumer<SignUpViewModel>(
                                          builder: (context, value, child) {
                                        return InkWell(
                                          onTap: () {
                                            if (validData() == true) {
                                              Map data = {
                                                'email': myControllerEmail.text,
                                                'password':
                                                    myControllerPassword.text,
                                                'name': myControllerName.text,
                                                'contact':
                                                    myControllerContact.text,
                                                'address':
                                                    myControllerAddress.text
                                              };
                                              if (value.signuploading ==
                                                  false) {
                                                value.signUpApi(
                                                    data: data,
                                                    context: context);
                                              }
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: size.width * .05,
                                            ),
                                            height: size.width / 8,
                                            width: size.width / 1.25,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColor.buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: value.signuploading == true
                                                ? ProgressIndecator
                                                    .loadingIndecator()
                                                : const Text(
                                                    'Sing Up',
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
                                      //text widget used to route user to login screen
                                      RichText(
                                        text: TextSpan(
                                          text: 'Login',
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.white,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                context,
                                                ScreenRoutes.login,
                                              );
                                            },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                isloading == true
                    ? const Center(child: CircularProgressIndicator())
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
//custom widget text field 
  Widget component({icon, hintText, isPassword, isEmail, textediting}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: textediting,

        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        //  controller: textediting,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,

        decoration: InputDecoration(
          // errorText: validateEmail(textediting.text),
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
