



import '../genres_model.dart';

class MovieDetailModel{
  final MovieDetails? details;
  final String? error;

  MovieDetailModel({this.details,this.error});

  factory MovieDetailModel.fromJson(Map<String,dynamic> json) =>MovieDetailModel(
    details: MovieDetails.fromJson(json),
    error: ""
  );
  factory MovieDetailModel.withError(String error)=>MovieDetailModel(
    details: MovieDetails(),
    error: error
  );
}

class MovieDetails {
  List<Genre>? genres;
  String? releasDate;
  int? id;
  double? rating;
  String? title;
  String? backDrop;
  String? poster;
  String? overview;
  int? runTime; 


  MovieDetails({
    this.title,
    this.releasDate,
    this.genres,
  this.id,
  this.rating,
  this.backDrop,
  this.poster,
  this.overview,
  this.runTime,


  });

  factory MovieDetails.fromJson(Map<String,dynamic> json)=>MovieDetails(
     title: json['title'],
    id: json['id'],
    genres: (json['genres'] as List).map((genre) => Genre.fromJson(genre)).toList(),
    
    rating: json['vote_average'].toDouble(),
    
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    overview: json['overview'],
    releasDate: json['release_date'],
    runTime: json['runtime']

  );
}