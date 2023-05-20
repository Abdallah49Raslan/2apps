import 'package:application_1/Abdallah/Authintication/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/space.dart';
import '../../core/text_style.dart';
import '../logic/LogInLogic.dart';
import '../widget/main_button.dart';
import '../widget/text_fild.dart';
import 'Forget_Pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, String? errorMessage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
  bool _isScure = true;
  bool _useFingerprint = false; // added boolean variable for fingerprint switch

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBG,
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // App logo
                Image.asset(
                  'assets/images/Home_logo.png',
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                ),

                const Text(
                  'Welcome Back!',
                  style: headline1,
                ),
                const SpaceVH(height: 10.0),
                const Text(
                  'Please sign in to your account',
                  style: headline3,
                ),
                const SpaceVH(height: 20.0),
                textField(
                  onChanged: (data) {
                    email = data;
                  },
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintTxt: 'Email Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                ),
                textField(
                  onChanged: (data) {
                    password = data;
                  },
                  controller: userPass,
                  prefixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isScure = !_isScure;
                      });
                    },
                    icon: Icon(
                      _isScure ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  isObs: _isScure,
                  keyboardType: TextInputType.visiblePassword,
                  hintTxt: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const ForgetPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: headline3,
                      ),
                    ),
                  ),
                ),
                //LogIn Button or fingerprint login
                const SpaceVH(height: 30.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Mainbutton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginLogic(
                                  email: email!,
                                  password: password!,
                                ),
                              ),
                            );
                          }
                        },
                        text: 'Sign in',
                        btnColor: blueButton,
                      ),
                      if (_useFingerprint)
                        Mainbutton(
                          onTap: () async {
                            // Implement fingerprint login logic here
                          },
                          text: 'Sign in with fingerprint',
                          btnColor: blueButton,
                        ),
                      //switch to signUp
                      const SpaceVH(height: 20.0),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const SignUpPage()));
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: headline3.copyWith(),
                            ),
                            const TextSpan(
                              text: ' Sign Up',
                              style: headline5,
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
