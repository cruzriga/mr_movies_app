import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_movies_app/models/movie_credits_resource.dart';
import 'package:mr_movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CastingCardWidget extends StatelessWidget {
  final int movieID;

  CastingCardWidget(this.movieID);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieID),
      builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
        if(!snapshot.hasData){
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            margin: const EdgeInsets.only(bottom: 30),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;
        return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(cast[index]),
            ));
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.profilefullPath),
              fit: BoxFit.cover,
              width: 100,
              height: 140,
            ),
          ),
          Text(
            actor.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
