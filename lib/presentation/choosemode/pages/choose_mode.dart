import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/themes/app_colors.dart';
import 'package:spotify/presentation/authentication/pages/signup_or_signin.dart';
import 'package:spotify/presentation/choosemode/bloc/theme_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/presentation/home/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseModeScreen extends StatelessWidget {
  Future<void> _handleGetStarted(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored email and password
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      try {
        // Sign in with Firebase Authentication
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Navigate to the root page if successful
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => RootPage()),
        );
      } catch (e) {
        log('Firebase sign-in failed: $e');
        // If Firebase sign-in fails, redirect to the login page
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => SignupOrSignin()),
        );
      }
    } else {
      // If no credentials are stored, redirect to the login page
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => SignupOrSignin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.choosemodebackground),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(AppVectors.spotifylogo)),
                Spacer(),
                Text(
                  'Choose Mode',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFDADADA)),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updatetheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(32, 255, 255, 255)),
                                child: SvgPicture.asset(
                                  AppVectors.moonicon,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Dark',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<ThemeCubit>()
                                .updatetheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(32, 255, 255, 255)),
                                child: SvgPicture.asset(
                                  AppVectors.sunicon,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Light',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                BasicAppButton(
                    onpressed: () {
                      _handleGetStarted(context);
                    },
                    text: 'Continue')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
