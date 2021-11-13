import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:mr_movies_app/models/models.dart';
class CardSwipperWidget extends StatelessWidget {
  final List<Movie> movies;

  CardSwipperWidget({
    Key? key,
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    if (movies.isEmpty) {
      return SizedBox(
          width: double.infinity,
          height: size.height * 0.5,
          child: const Center(
            child: CircularProgressIndicator(),
          ));
    }
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child:Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.54,
        itemHeight: size.height * 0.45,
        itemBuilder: (context, int index){
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movies[index].posterFullPath),
                  fit: BoxFit.cover
              ),
            ),
          );
        },
      )
    );
  }
}
