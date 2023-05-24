import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/space.dart';
import '../../core/text_style.dart';
import '../../logic/SignUpLogic.dart';
import '../../logic/validator.dart';
import '../../onboding_screen.dart';
import '../../widget/Dropdown_Menu.dart';
import '../../widget/main_button.dart';
import '../../widget/text_fild.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPh = TextEditingController();
  TextEditingController personId = TextEditingController();
  TextEditingController driverLicense = TextEditingController();

  bool _isScure = true;
  final List<String> options = ['Driver', 'Customer'];

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? email;
  String? password;
  String? Name;
  String? phone;
  String? selectedOption;
  String? UserID;
  String? DriverLic;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //head of page
                SpaceVH(height: screenWidth > 480 ? 60 : 30.0),
                Text(
                  'Create new account',
                  style: screenWidth > 480
                      ? headline.copyWith(fontSize: 60)
                      : headline,
                ),

                //text hint
                SpaceVH(height: screenWidth > 480 ? 20 : 10.0),
                Text(
                  'Please fill in the form to continue',
                  style: screenWidth > 480
                      ? headline4.copyWith(fontSize: 20)
                      : headline4,
                ),

                //userName
                SpaceVH(height: screenWidth > 480 ? 40 : 20.0),
                textField(
                  onChanged: (data) {
                    Name = data;
                  },
                  controller: userName,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  keyboardType: TextInputType.name,
                  hintTxt: 'Full Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SpaceVH(height: screenWidth > 480 ? 20 : 0.0),
                //userEmail
                textField(
                  onChanged: (data) {
                    email = data;
                  },
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  hintTxt: 'Email Address',
                  validator: InputValidator.emailValidator,
                ),
                SpaceVH(height: screenWidth > 480 ? 20 : 0.0),
                //user Number
                textField(
                  onChanged: (data) {
                    phone = data;
                  },
                  controller: userPh,
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                  hintTxt: 'Phone Number',
                  validator: InputValidator.phoneValidator,
                ),
                SpaceVH(height: screenWidth > 480 ? 20 : 0.0),
                //user Password
                textField(
                  onChanged: (data) {
                    password = data;
                  },
                  controller: userPass,
                  isObs: _isScure,
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
                  keyboardType: TextInputType.visiblePassword,
                  hintTxt: 'Password',
                  validator: InputValidator.passwordValidator,
                ),
                SpaceVH(height: screenWidth > 480 ? 20 : 0.0),
                // user role
                UserRoleDropdown(
                  hintTxt: 'Please select your role',
                  options: options,
                  selectedOption: selectedOption,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  onChanged: (newValue) {
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                  validator: (value) {
                    // add custom validation logic here
                    return null;
                  },
                ),

                // conditional text fields for driver ID and license number
                if (selectedOption == 'Driver')
                  Column(children: [
                    SpaceVH(height: screenWidth > 480 ? 20 : 0.0),
                    textField(
                      onChanged: (data) {
                        UserID = data; // save driver ID data
                      },
                      controller: personId,
                      prefixIcon: const Icon(Icons.credit_card_sharp),
                      keyboardType: TextInputType.number,
                      hintTxt: 'Driver ID',
                      validator: InputValidator.idValidator,
                    ),
                    SpaceVH(height: screenWidth > 480 ? 20 : 0.0),
                    textField(
                      onChanged: (data) {
                        DriverLic = data; // save driver license data
                      },
                      controller: driverLicense,
                      prefixIcon: const Icon(Icons.credit_card),
                      keyboardType: TextInputType.number,
                      hintTxt: 'Driver License Number',
                      validator: InputValidator.licenseValidator,
                    ),
                  ]),

                // sign up button
                SpaceVH(height: screenWidth > 480 ? 40 : 20.0),
                Mainbutton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpLogic(
                            email: email!,
                            password: password!,
                            name: Name!,
                            phone: phone!,
                            role: selectedOption!,
                          ),
                        ),
                      );
                    } else {
                      // handle case when form is not valid
                    }
                  },
                  text: 'Sign Up',
                  btnColor: blueButton,
                ),

                //switch to Login
                SpaceVH(height: screenWidth > 480 ? 30 : 10.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OnboardingScreen()));
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Have an account? ',
                        style: screenWidth > 480
                            ? headline3.copyWith(fontSize: 18)
                            : headline3,
                      ),
                      TextSpan(
                        text: ' Sign In',
                        style: screenWidth > 480
                            ? headline4.copyWith(
                                color: primaryColor, fontSize: 20)
                            : headline4.copyWith(color: primaryColor),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
