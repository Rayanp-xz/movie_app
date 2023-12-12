


import 'package:flutter/material.dart';
import 'package:movie_app/movie-app-main/MovieApp/Screens/movie_details.dart';

import '../Http_request.dart';

import '../Movie/movie_model.dart';
import '../MvieApp2/Styles.dart';

class UpcomingMovie extends StatefulWidget {
  const UpcomingMovie({super.key,required this.text,required this.request});
  final String text;
  final String request;

  @override
  State<UpcomingMovie> createState() => _UpcomingMovieState();
}

class _UpcomingMovieState extends State<UpcomingMovie> {
  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 10,),
            child: Text("${widget.text} MOVIES",style: TextStyle(color: Style.textColor,fontWeight: FontWeight.w600,fontSize: 12),),
          ),
          SizedBox(height: 5,),
          FutureBuilder<MovieModel>(future: HttpRequest.getMovies(widget.request),
         builder: (context,AsyncSnapshot<MovieModel> snapshot){
           if(snapshot.hasData){
             if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
               return _ErrorWidget(snapshot.data!.error);
             }

             return MovieGenreWidret(snapshot.data!);
           }else if(snapshot.hasError){
             return _ErrorWidget(snapshot.error);
           }else{
             return LoadingWidget();
           }
         }),
        ],
      
    );
  }
   Widget LoadingWidget(){
    return Padding(
      padding: const EdgeInsets.only(top: 300),
      child: Center(
        child: Column(children: [
          SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(

              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ]),
      ),
    );
  }
  Widget _ErrorWidget(dynamic error){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Something is wrong : $error')
        ],
      ),
    );
  }


  Widget MovieGenreWidret(MovieModel data){
      List<Movie>? movies=data.movies;
       if(movies!.isEmpty){
        return SizedBox(
          child: Text( 'No Movies found',style: TextStyle(color: Style.textColor,fontSize: 20),),
        );
       }else{
        return Container(
          height: 270,
          padding: EdgeInsets.only(left: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context,index){
              return Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 10),
              child:GestureDetector(
                onTap: (){
                },
                child: Column(children: [
                  movies[index].poster==null ? InkWell(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 4),
                          dismissDirection: DismissDirection.horizontal,
                          backgroundColor: Colors.grey,
                          content: Text('No data found')));
                    },
                    child: Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Style.SecColor,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        shape: BoxShape.rectangle
                      ),child: Center(
                        child: Icon(Icons.videocam_off,color: Style.textColor,size: 50,),
                      ),
                    ),
                  ) : Hero(
                    tag: "${movies[index].id}",
                    child: InkWell(
                      onTap: (){
                        movies[index].poster!= null ? Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return MovieDetails(movie:movies[index] ,);
                        })) : Container();
                      },
                      child: Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Style.SecColor,
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200"+ movies[index].poster!),fit: BoxFit.cover)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width:100,
                    child:Text(movies[index].title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:Colors.white,height: 1.4,fontSize: 10,fontWeight: FontWeight.bold
                    ),) ,),
                ]),
              ) ,
              );
            }),
        );
       }
  }
}