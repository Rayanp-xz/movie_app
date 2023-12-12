
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../Screens/HomePage.dart';
import '../Screens/PageIndicator.dart';

import 'Movie2HomePage.dart';
import 'Styles.dart';



class MovieMain extends StatefulWidget {
  const MovieMain({super.key});

  @override
  State<MovieMain> createState() => _MovieMainState();
}

final _pages=[
  PageIndicator(),
    MovieHome(),
     MovieExplorerHomePage(),


];
int index=0;
class _MovieMainState extends State<MovieMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:_pages[index],
     // _pages[index],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (vale){
            setState(() {
              index=vale;
            });
        },
        height: 74,
        index:index,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Style.SecColor,
        color:Color.fromARGB(255, 16, 25, 32),
        
        items: [
          Icon(Icons.tv,color: Style.textColor),
          Icon(Icons.movie,color: Style.textColor),
          Icon(Icons.list,color: Style.textColor)
        ]),
    );
  }
}