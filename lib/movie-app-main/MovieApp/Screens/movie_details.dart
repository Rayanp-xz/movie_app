
import 'package:flutter/material.dart';
import 'package:movie_app/movie-app-main/MovieApp/Screens/review_list.dart';
import 'package:movie_app/movie-app-main/MovieApp/Screens/similar_movie_widgets.dart';
import 'package:movie_app/movie-app-main/MovieApp/Screens/trailer_video.dart';

import '../Movie/movie_model.dart';
import '../MvieApp2/Styles.dart';
import 'movie_info.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key,required this.movie});
  final Movie movie;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.keyboard_arrow_left,color: Style.textColor,size: 38,)),
        title: Text(widget.movie.title!.toUpperCase(),
        overflow: TextOverflow.ellipsis,style: TextStyle(color: Style.textColor),),
      ),
      body: ListView(

          children: [

        Container(
          height: 350,
          child: Stack(
           
            children: [
              _BuildBackDrop(),
             BuildPoster(),

          
            ],
          ),

        ),
        MovieInfo(id: widget.movie.id!,),
            SimilarMovies(id: widget.movie.id!,),
            ReviewList(id:widget.movie.id! ,request: 'movie',)

      ]),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(child: Container(

              color: Colors.redAccent,
              child: TextButton.icon(onPressed: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (_){
                //   return TrailerPlayer(shows: "movie",id: widget.movie.id!,);
                // }));

              }, icon: const Icon(Icons.play_circle_fill_rounded,
                color: Colors.white,size: 30,), label:const Text("Watch Trailers",style: TextStyle(fontSize: 15,color: Colors.white),)),
            )),
            Expanded(child: Container(

              color:Style.SecColor,
              child: TextButton.icon(onPressed: (){}, icon: const Icon(Icons.list_alt_outlined,color: Colors.white,size: 30,),
                  label:const Text("Add To Lists",style: TextStyle(fontSize: 15,color: Colors.white),)),
            ))
          ],
        ),

      ],
    );
  }

  Widget BuildPoster() {
    return Positioned(
            top: 150,
            left: 30,
             child: Hero(
               tag: "${widget.movie.id!}",
               child: Card(
                elevation: 70,
                
                 child: Container(
                  width: 150,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200/" + widget.movie.poster!),fit: BoxFit.cover)
                  ),
                 
                 ),
               ),
             ),
           );
  }

  Widget _BuildBackDrop() {
    return Container(
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(image: 
                NetworkImage('https://image.tmdb.org/t/p/original/' + widget.movie.backDrop!),fit: BoxFit.cover)
              ),
            );
  }
}