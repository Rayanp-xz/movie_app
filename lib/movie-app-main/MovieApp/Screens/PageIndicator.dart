

import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import '../Http_request.dart';
import '../Movie/movie_model.dart';
import '../MvieApp2/Styles.dart';

class PageIndicator extends StatefulWidget {
  const PageIndicator({super.key});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<MovieModel>(future: HttpRequest.getMovies("now_playing"),
         builder: (context,AsyncSnapshot<MovieModel> snapshot){
           if(snapshot.hasData){
             if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
               return _ErrorWidget(snapshot.data!.error);
             }

             return PlayingWidget(snapshot.data!);
           }else if(snapshot.hasError){
             return _ErrorWidget(snapshot.error);
           }else{
             return LoadingWidget();
           }
         }
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


  Widget PlayingWidget(MovieModel data){
        List<Movie>? movies = data.movies;
        if(movies!.isEmpty){
          return SizedBox(
            height: 290,
            child: Center(
              child: Text("No Movies found",style: TextStyle(color: Style.textColor),),
              
            ),
          );
        }else{
         return Column(
           children: [
             SizedBox(
              height: 220,
              child:PageIndicatorContainer(
                align: IndicatorAlign.bottom,
                indicatorSpace: 8,
                padding: EdgeInsets.all(5),
                indicatorColor: Style.textColor,
                indicatorSelectorColor: Style.SecColor,
                length: movies.take(5).length,
                shape: IndicatorShape.circle(size: 10),
                child:PageView.builder(
                  itemCount: movies.take(5).length,
                  itemBuilder:(context,index){
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 290,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image:NetworkImage('https://image.tmdb.org/t/p/original' + movies[index].backDrop!)
                              ,fit: BoxFit.cover )
                          ),
                        ),
                        
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0,0.9],
                              colors: [Style.primaryColor.withOpacity(1),Style.primaryColor.withOpacity(0)])
                          ),
                        ),
                        Positioned(
                          bottom: 30.0,
                          child:Container(
                            padding: EdgeInsets.only(left: 10,right: 50),
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 movies[index].title!,style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                 ),
                              )],
                            )
                            
                          ) )
                      ],
                    );
                  } ) ) ),
             Text("hello ,",style: TextStyle(color:Colors.white),)
           ],
         );
        }
  }



}

