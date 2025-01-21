import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/getstarted/pages/get_started.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
      child: SvgPicture.asset(
        AppVectors.spotifylogo,
      ),
    ));
  }

  void redirect() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => GetStartedPage()));
  }
}
