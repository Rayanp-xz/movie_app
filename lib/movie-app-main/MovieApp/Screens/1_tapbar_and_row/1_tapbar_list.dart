
import 'package:flutter/material.dart';

import '../../MvieApp2/Styles.dart';
import '../../genres_model.dart';
import '1_movies.dart';

class GenresList extends StatefulWidget {
  const GenresList({super.key,required this.genres});
final List<Genre> genres;
  @override
  State<GenresList> createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin{
  TabController? _controller;
  @override
  void initState() {
    _controller=TabController(length: widget.genres.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: DefaultTabController(
        length: widget.genres.length,
        child: Scaffold(appBar:PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              indicatorColor: Style.SecColor,
              indicatorWeight:3,
              controller:_controller,
              tabs: widget.genres.map((Genre genre) {
                return Container(
                  padding: EdgeInsets.only(
                    bottom: 15,
                    top: 10
                  ),
                  child: Text(genre.name!.toUpperCase(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Style.textColor),),
                );

              }).toList()
            ),
          )
          ,),
          body: TabBarView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            children: widget.genres.map((Genre genre){
            return TapBarMovie(genreId:genre.id! ,);
          }).toList()
          ),
           )
           ),
    );
  }
}