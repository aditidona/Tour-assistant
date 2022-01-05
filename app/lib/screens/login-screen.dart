import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/pallete.dart';
import '/widgets/widgets.dart';
import '../authenthication/auth.dart';
import 'home_page.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void login() {
    var f = formkey.currentState;
    if (f != null) {
      if (f.validate()) {
        formkey.currentState!.save();
        signin(email, password, context).then((value) {
          if (value != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(uid: value.uid)
                    /* TasksPage(
                  uid: value.uid,
                ),*/
                    ));
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(
          image: 'images/login-screen-bg.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'WanderLust',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Padding(
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
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "This Field Is Required"),
                                EmailValidator(
                                    errorText: "Invalid Email Address"),
                              ]),
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
                              },
                              style: kBodyText,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: /*PasswordInput(
                        icon: FontAwesomeIcons.lock,
                        hint: 'Password',
                        inputAction: TextInputAction.done,
                        newvalue: (val) {
                          password = val;
                        },
                      ),*/
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
                                    errorText: "Password Is Required"),
                                MinLengthValidator(6,
                                    errorText: "Minimum 6 Characters Required"),
                              ]),
                              obscureText: true,
                              style: kBodyText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              onChanged: (val) {
                                password = val;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, 'ForgotPassword'),
                      child: Center(
                        child: Text(
                          'Forgot Password',
                          style: kBodyText,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: SizedBox(
                        width: 160,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueGrey),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => googleSignIn().whenComplete(() async {
                        User? user = FirebaseAuth.instance.currentUser!;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage(
                                uid: user.uid) /*TasksPage(uid: user.uid)*/));
                      }),
                      child: Center(
                        child: Image(
                          image: AssetImage('images/googleSignIn.jpg'),
                          width: 200.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/createnewaccount'),
                child: Container(
                  child: Text(
                    'Create New Account',
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
