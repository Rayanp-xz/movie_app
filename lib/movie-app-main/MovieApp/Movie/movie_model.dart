class MovieModel{
  final List<Movie>? movies;
  final String? error;

  MovieModel({this.movies,this.error});

  factory MovieModel.fromJson(Map<String,dynamic> json) =>MovieModel(
    movies: (json["results"] as List).
    map((data) => Movie.fromJson(data)).toList(),
    error: ""
  );
  factory MovieModel.withError(String error)=>MovieModel(
    movies: [],
    error: error
  );
}

class Movie {
  String? title;
  int? id;
  double? rating;
  String? backDrop;
  String? poster;
  String? overview;


  Movie({
    this.title,
  this.id,
  this.rating,
  
  this.backDrop,
  this.poster,
  this.overview

  });

  factory Movie.fromJson(Map<String,dynamic> json)=>Movie(
    title: json['title'],
    id: json['id'],
    rating: json['vote_average'].toDouble(),
    
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    overview: json['overview'],

  );
}