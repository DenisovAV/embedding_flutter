import 'package:flutter/material.dart';
import 'package:movies_flutter_module/domain/movie.dart';

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({required this.movie, Key? key}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      const SizedBox(
        height: 10.0,
      ),
      Center(
        child: Text(
          movie.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 10),
        child: Text(
          movie.meta,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          movie.synopsis,
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Text(
          'Rating: ${movie.rating}',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
      ),
    ];

    return Material(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: movie.name,
                  child: Image.asset(
                    'assets/images/${movie.image}.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(widgets),
            ),
          ],
        ),
      ),
    );
  }
}
