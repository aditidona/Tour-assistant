import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/pallete.dart';
import '/widgets/widgets.dart';
import '../authenthication/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'home_page.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  late String username;
  late String email;
  late String password;
  late String confirmPassword;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      signUp(email.trim(), password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(uid: value.uid),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'images/signin-screen-bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.3,
                ),
                /*Stack(
                  children: [
                    /*Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )*/
                  ],
                ),*/
                SizedBox(
                  height: size.width * 0.1,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.grey[500]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              onChanged: (val) {
                                username = val;
                                print(username);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: "User Name",
                                hintStyle: kBodyText,
                              ),
                              style: kBodyText,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.grey[500]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.envelope,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: kBodyText,
                              ),
                              onChanged: (val) {
                                email = val;
                                print(email);
                              },
                              validator: (_val) {
                                if (_val!.isEmpty) {
                                  return "Can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              style: kBodyText,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.grey[500]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle: kBodyText,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "This Field Is Required."),
                                MinLengthValidator(6,
                                    errorText: "Minimum 6 Characters Required.")
                              ]),
                              obscureText: true,
                              style: kBodyText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              onChanged: (val) {
                                password = val;
                                print(password);
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.grey[500]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 28,
                                    color: kWhite,
                                  ),
                                ),
                                hintText: ' Confirm Password',
                                hintStyle: kBodyText,
                              ),
                              obscureText: true,
                              style: kBodyText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              onChanged: (val) {
                                confirmPassword = val;
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "This Field Is Required."),
                                MinLengthValidator(6,
                                    errorText: "Minimum 6 Characters Required.")
                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 160,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: handleSignup,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey),
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: kBodyText,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              'Login',
                              style: kBodyText.copyWith(
                                  color: kBlue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
