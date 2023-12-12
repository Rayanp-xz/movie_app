import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'package:flutter/material.dart';


import '../MvieApp2/MovieMain.dart';
import '../MvieApp2/Styles.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/images/movie_logo.png",fit: BoxFit.cover,height: 300,),
      title: const Text(
        "SIUTIFY",
        style: TextStyle(
          fontFamily: "ray font",
          fontSize: 25,color: Style.SecColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Style.primaryColor,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: MovieMain(),
      durationInSeconds: 3,
    );
  }
}