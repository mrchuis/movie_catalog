import 'package:film_catalog_app/common/app_colors.dart';
import 'package:film_catalog_app/feature/domain/entities/movie_entity.dart';
import 'package:film_catalog_app/feature/presentation/widgets/movie_cache_image_widget.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({required this.movie});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          backgroundColor: AppColors.cellBackground,
          content: Text(
            movie.originalTitle,
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: MovieCacheImage(
                height: 240,
                width: 160,
                imageUrl:
                    'http://image.tmdb.org/t/p/original/${movie.posterPath}',
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 8),
                height: 240,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          movie.originalTitle,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          movie.overview,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      child: Text(movie.releaseDate),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
