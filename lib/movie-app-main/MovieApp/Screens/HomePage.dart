
import 'package:flutter/material.dart';
import 'package:movie_app/movie-app-main/MovieApp/Screens/upcoming_widget.dart';

import '1_tapbar_and_row/1_tapbar_genres.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({super.key});

  @override
  State<MovieHome> createState() => _MovieHomeState();
}


class _MovieHomeState extends State<MovieHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: ListView(
       children: [

        TapBarGenres(),
        UpcomingMovie(text:'UPCOMING' ,request: 'upcoming',),
        UpcomingMovie(text: 'POPULAR',request: 'popular',),



       ],
      ),
    );
  }

 
}

