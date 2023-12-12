


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Http_request.dart';
import '../Movie/movie_details_model.dart';
import '../MvieApp2/Styles.dart';
import '../genres_model.dart';

class MovieInfo extends StatefulWidget {
  const MovieInfo({super.key,required this.id});
  final int id;

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailModel>(future: HttpRequest.getMoviesDetails(widget.id),
        builder: (context,AsyncSnapshot<MovieDetailModel> snapshot){
          if(snapshot.hasData){
            if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
              return _ErrorWidget(snapshot.data!.error);
            }

            return _buildInfoWidget(snapshot.data!);
          }else if(snapshot.hasError){
            return _ErrorWidget(snapshot.error);
          }else{
            return LoadingWidget();
          }
        });
  }
  Widget _buildInfoWidget(MovieDetailModel data){
    MovieDetails detail=data.details!;
    return Column(
      children: [
        _buildRating(detail),
        SizedBox(
          height: 10,
        ),
        _buildOverView(detail.overview),
        SizedBox(
          height: 10,
        ),
        _buildGenreList(detail.genres),


      ],
    );
  }
  Widget _buildGenreList(List<Genre>? genres){
     return Padding(
       padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("GENRES",style: TextStyle(
               color: Style.textColor,
               fontWeight: FontWeight.w600,
               fontSize: 12
           ),),
           Container(
             height: 35,
             padding: EdgeInsets.only(top: 10),

             child: ListView.builder(
               scrollDirection: Axis.horizontal,
                 itemCount: genres!.length,
                 itemBuilder: (context,index){
               return Padding(

                 padding: const EdgeInsets.only(right: 10),
                 child: Container(
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(5)),
                     border: Border.all(width: 1,color: Colors.white),
                   ),
                   child: Text(
                     genres[index].name!,
                     style: TextStyle(
                       color: Colors.white,

                       fontSize: 11
                     ),
                   ),
                 ),
               );
             }),

           )
         ],
       ),
     );
  }

  Widget _buildOverView(String? overview){
    return Padding(
      padding: const EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("OVERVIEW",style: TextStyle(
              color: Style.textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12
          ),),
          SizedBox(
            height: 10,
          ),
          Text(overview!,style: TextStyle(
              color: Colors.white,

              fontSize: 14,
            height: 1.5

          ),),
        ],
      ),
    );
  }

  Widget _buildRating(MovieDetails details){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        SizedBox(
          width: 120,
        ),
        Expanded(child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(7),
                       color: Colors.redAccent,
                     ),

                      width: 69,
                      height: 30,

                      child: Center(
                        child: Text(details.rating!.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    // RatingBar.builder(itemBuilder: (context,_){
                    //   return const Icon(Icons.star,size: 2,color: Color(0xFFF4C10f),);
                    // }, onRatingUpdate: (rating){
                    //
                    // })
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DURATION",style: TextStyle(
                          color: Style.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${details.runTime!} mins',style: TextStyle(
                          color: Style.SecColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("RELEASE DATE",style: TextStyle(
                            color: Style.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${details.releasDate!} ',style: TextStyle(
                          color: Style.SecColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),)
                      ],
                    )

                  ],
                ),
              )
            ],
          ),
        ))
      ],),
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
          Text('Somthing is wrong : $error')
        ],
      ),
    );
  }
}
