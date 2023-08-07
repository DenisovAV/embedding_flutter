import 'package:flutter/cupertino.dart';
import 'package:movies_flutter_module/domain/movie.dart';
import 'package:movies_flutter_module/ui/widgets/movie_card/mobile_movie_card.dart';

typedef MyBuilder = Widget Function({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
});

MyBuilder getMovieCard() => getMobileCard;

Widget getMobileCard({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
}) =>
    MovieCard(
      movie: movie,
      index: index,
      onTap: onTap,
      key: ValueKey(movie.name),
    );
