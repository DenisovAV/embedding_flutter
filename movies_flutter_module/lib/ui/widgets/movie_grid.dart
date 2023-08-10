import 'package:flutter/material.dart';
import 'package:movies_flutter_module/domain/movie.dart';
import 'package:movies_flutter_module/ui/widgets/movie_card/movie_card.dart';

typedef MovieTapHandler = void Function(Movie);

class MovieGridWidget extends StatelessWidget {
  MovieGridWidget({
    required this.movies,
    required this.onTapMovie,
    Key? key,
  }) : super(key: key);

  final controller = ScrollController();
  final List<Movie> movies;
  final MovieTapHandler onTapMovie;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(28),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).size.width / 200).round(),
              childAspectRatio: 1.6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => getMovieCard()(
                movie: movies[index],
                index: index,
                onTap: () => onTapMovie(movies[index]),
              ),
              childCount: movies.length,
            ),
          ),
        )
      ],
    );
  }
}
