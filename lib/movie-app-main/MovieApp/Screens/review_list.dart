import 'package:flutter/material.dart';

import '../Http_request.dart';

import '../MvieApp2/Styles.dart';
import '../rewiews_model.dart';
class ReviewList extends StatefulWidget {
   const ReviewList({super.key,required this.id,required this.request});
   final int id;
   final String request;

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
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
          FutureBuilder<ReviewsModel>(future: HttpRequest.getReviews(widget.request,widget.id),
              builder: (context,AsyncSnapshot<ReviewsModel> snapshot){
                if(snapshot.hasData){
                  if(snapshot.data!.error !=null && snapshot.data!.error!.isNotEmpty){
                    return _ErrorWidget(snapshot.data!.error);
                  }

                  return BuildReview(snapshot.data!);
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
          Text('Somthing is wrong : $error')
        ],
      ),
    );
  }

  Widget BuildReview(ReviewsModel data){
    List<Review>? reviews= data.reviews;
    if(reviews!.isEmpty){
      return SizedBox(
        height: 100,
          child: Center(
            child: Text("There is no reviews shown",style: TextStyle(
              fontSize: 20,color: Colors.white
            ),),
          ),
      );
    }else{
      return Column(
        children: List.generate(reviews.length, (index) {
          return Card(
            color: Style.textColor,
            margin: EdgeInsets.symmetric(vertical: 10),
            elevation: 5,
            child: ListTile(
              title: Text(
                reviews[index].content!,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          );
        }),

      );
    }
  }
}
