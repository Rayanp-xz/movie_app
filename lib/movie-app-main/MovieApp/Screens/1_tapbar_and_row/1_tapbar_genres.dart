
import 'package:flutter/material.dart';

import '../../Http_request.dart';
import '../../MvieApp2/Styles.dart';
import '../../genres_model.dart';
import '1_tapbar_list.dart';

class TapBarGenres extends StatefulWidget {
  const TapBarGenres({super.key});

  @override
  State<TapBarGenres> createState() => _TapBarGenresState();
}

class _TapBarGenresState extends State<TapBarGenres> {
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
         
          FutureBuilder<GenreModel>(future: HttpRequest.getGenres("movie"),
             builder: (context,AsyncSnapshot<GenreModel> snapshot){
               if(snapshot.hasData){
                 if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
                   return _ErrorWidget(snapshot.data!.error);
                 }

                 return GetGenresWidget(snapshot.data!);
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
          Text('Somthing is wrong : $error')
        ],
      ),
    );
  }

 Widget GetGenresWidget(GenreModel data){
    List<Genre>? genres=data.genres;
      if(genres!.isEmpty){
         return SizedBox(
           child: Text("No Genres",style: TextStyle(fontSize:20,color: Style.textColor),),
           
         );
      }else{
        return GenresList(genres: genres,);
      }
 }

}