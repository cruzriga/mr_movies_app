import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_movies_app/models/models.dart';

class MovieSliderWidget extends StatelessWidget {
  final List<Movie> movies;
  final String? title;

  MovieSliderWidget({Key? key, required this.movies, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title != null) Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!, // -> reemplazar
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length, //  cambiar legnt
                itemBuilder: (_, index) => _MoviesPoster(
                      movie: movies[index],
                    ) // ->> obligatorio movies
                ),
          )
        ],
      ),
    );
  }
}

class _MoviesPoster extends StatelessWidget {
  final Movie movie;

  _MoviesPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //  color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details',
              arguments: 'movie-instance'),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.posterFullPath),
                  fit: BoxFit.cover,
                  width: 130,
                  height: 190,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
