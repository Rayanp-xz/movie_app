
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import 'MovieClass.dart';
import 'MvieDisplayPage.dart';
import 'Styles.dart';


class MovieListView extends StatelessWidget {
  final List<Movie> movies;

  const MovieListView({required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Card(
          color: Style.primaryColor,
          child: ListTile(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return MovieDisplay();
              }));
            },
            leading: CachedNetworkImage(
              imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
          width: 60,
              height: 90,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(movie.title,style: TextStyle(color: Colors.white),),
          subtitle: Text(movie.overview,style: TextStyle(color: Style.textColor)),
            trailing: Text('Rating: ${movie.voteAverage}',style: TextStyle(color:Style.textColor)),
          ),
        );
      },
    );
  }
}