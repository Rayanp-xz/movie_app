
import 'package:flutter/material.dart';

import '../Http_request.dart';
import '../Movie/movie_model.dart';
import '../MvieApp2/Styles.dart';
import 'movie_details.dart';

class SimilarMovies extends StatefulWidget {
  const SimilarMovies({super.key,required this.id});
final int id;
  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Text("SIMILAR MOVIES",style: TextStyle(
              color: Style.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12
          ),),

          SizedBox(
            height: 3,
          ),
          FutureBuilder<MovieModel>(future: HttpRequest.getSimilarMovies(widget.id),
                builder: (context,AsyncSnapshot<MovieModel> snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
                      return _ErrorWidget(snapshot.data!.error);
                    }

                     return SimilarMovieWidget(snapshot.data!);
                  }else if(snapshot.hasError){
                    return _ErrorWidget(snapshot.error);
                  }else{
                    return LoadingWidget();
                  }
                }
          ),
        ],
      ),
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

  Widget SimilarMovieWidget(MovieModel data){
    List<Movie>? movies=data.movies;
    if(movies!.isEmpty){
      return SizedBox(
        height: 100,
        child: Text( 'No Movies found',style: TextStyle(color: Style.textColor,fontSize: 20),),
      );
    }else{
      return Container(

        height: 170,
        padding: EdgeInsets.only(left: 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context,index){
              return Padding(padding: EdgeInsets.only(top: 10,bottom: 10,right: 10),
                child:Column(children: [
                  movies[index].poster==null ? InkWell(
                    onTap: (){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 4),
                          dismissDirection: DismissDirection.horizontal,
                          backgroundColor: Style.textColor,
                          content: Text('No data found')));
                    },
                    child: Container(
                      width: 120,
                      height: 110,
                      decoration: BoxDecoration(
                          color: Style.SecColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          shape: BoxShape.rectangle
                      ),child: Center(
                      child: Icon(Icons.videocam_off,color: Style.textColor,size: 50,),
                    ),
                    ),
                  ) : Hero(
                    tag: "",
                    child: InkWell(
                      onTap: (){
                        movies[index].backDrop !=null ?  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return MovieDetails(movie:movies[index] ,);
                        })) :ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data not found")));
                      },
                      child:movies[index].poster !=null ? Container(
                        width: 120,
                        height: 110,
                        decoration: BoxDecoration(
                            border: Border.all(width: 8,color: Colors.black),
                            color: Style.SecColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w200"+ movies[index].poster!),fit: BoxFit.cover)
                        ),
                      ) : Container(
                        color: Colors.amber,
                        width: 120,
                        height: 110,

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
                ]) ,
              );
            }),
      );
    }
  }
}
