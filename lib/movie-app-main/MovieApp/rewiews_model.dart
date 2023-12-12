class ReviewsModel {
  final List<Review>? reviews;
  final String? error;

 ReviewsModel({this.reviews,this.error});

  factory ReviewsModel.fromJson(Map<String,dynamic> json) =>ReviewsModel(
    reviews: (json["results"] as List).
    map((data) =>Review.fromJson(data)).toList(),
    error: ""
  );
  factory ReviewsModel.withError(String error)=>ReviewsModel(
    reviews: [],
    error: error
  );
}

class Review {
  int? id;
  String? author;
  String? content;


  Review({this.content,this.author,this.id});

  factory Review.fromJson(Map<String,dynamic> json) =>Review(
    id: json['id'],
    author: json['author'],
    content: json['content']
  );
}