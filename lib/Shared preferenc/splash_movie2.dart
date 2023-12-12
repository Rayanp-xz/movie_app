
import 'package:flutter/material.dart';

class MovieSplash extends StatefulWidget {
  const MovieSplash({super.key});

  @override
  State<MovieSplash> createState() => _MovieSplashState();
}


class _MovieSplashState extends State<MovieSplash> {
  @override
  void initState() {
    SplashWidget();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Image.asset("assets/images/movie.png",fit: BoxFit.cover,),
    );
  }
  void SplashWidget()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return LginPageDemo();
    }));
  }

}
