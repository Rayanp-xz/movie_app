

import '../genres_model.dart';

class TVDetailModel{
  final TVDetails? details;
  final String? error;

  TVDetailModel({this.details,this.error});

  factory TVDetailModel.fromJson(Map<String,dynamic> json) =>TVDetailModel(
    details: TVDetails.fromJson(json),
    error: ""
  );
  factory TVDetailModel.withError(String error)=>TVDetailModel(
    details: TVDetails(),
    error: error
  );
}

class TVDetails {
  List<Genre>? genres;
  String? firstAirDate;
  int? id;
  double? rating;
  String? name;
  String? backDrop;
  String? poster;
  String? overview;
  int? numberOfEpisodes; 


  TVDetails({
    this.firstAirDate,
    this.genres,
  this.id,
  this.rating,
  this.name,
  this.backDrop,
  this.poster,
  this.overview,
  this.numberOfEpisodes,


  });

  factory TVDetails.fromJson(Map<String,dynamic> json)=>TVDetails(

    id: json['id'],
    genres: (json['genres'] as List).map((genre) => Genre.fromJson(genre)).toList(),
    
    rating: json['vote_average'].toDouble(),
    name: json['title'],
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    overview: json['overview'],
    firstAirDate: json['first_air_date'],
    numberOfEpisodes: json['number_of_seasons']
  );
}