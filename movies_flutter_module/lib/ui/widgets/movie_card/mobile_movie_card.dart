import 'package:flutter/material.dart';
import 'package:movies_flutter_module/domain/movie.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.movie,
    required this.index,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final int index;
  final GestureTapCallback? onTap;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Hero(
        tag: movie.name,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/${movie.image}.png'),
            ),
          ),
        ),
      ),
    );
  }
}
