


import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

import '../Http_request.dart';
import '../trailers_model.dart';

class TrailerPlayer extends StatefulWidget {
  const TrailerPlayer({super.key,required this.shows,required this.id});
  final String shows;
  final int id;
  @override
  State<TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<TrailerPlayer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrailersModel>(future: HttpRequest.getTrailers(widget.shows,widget.id),
        builder: (context,AsyncSnapshot<TrailersModel> snapshot){
          if(snapshot.hasData){
            // if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
            //   return _ErrorWidget(snapshot.data!.error);
            //
            // }

            return TrailerWidget(snapshot.data!);
          }else if(snapshot.hasError){
            return _ErrorWidget(snapshot.error);
          }else if(snapshot.data ==null){
            return LoadingWidget();
          }else{
            return LoadingWidget();
          }
        });
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

  Widget TrailerWidget(TrailersModel data){
    List<Video>? videos=data.trailers;
    return Stack(
      children: [
        Center(
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videos![2].key!,
              flags: YoutubePlayerFlags(
                hideControls: true,
                autoPlay: true,
              )
            ),

          ),
        ),
        Positioned(
          top: 40,
            right: 20,
            child: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.close_sharp),
          color: Colors.white,
        ))
      ],
    );
  }

}
