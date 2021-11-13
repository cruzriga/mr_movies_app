import 'package:flutter/material.dart';
import 'package:mr_movies_app/models/models.dart';
import 'package:mr_movies_app/widgets/casting_card_widget.dart';

// ignore: use_key_in_widget_constructors
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie =  ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie),
            SliverList(
                delegate: SliverChildListDelegate([
                  _PosterAndTitle(movie),
                  _Overview(movie),
                  _Overview(movie),
                  _Overview(movie),
                  CastingCardWidget()
                ])),
          ],
        )
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme =  Theme.of(context).textTheme;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.posterFullPath),
              height: 150,
            ),
          ),
         const SizedBox(width: 20,),
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenSize.width - 190),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,style:textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.left,),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.caption, overflow: TextOverflow.ellipsis),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(movie.title, style: TextStyle(fontSize: 16)),
        ),
        background:  FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image:NetworkImage(movie.backdropFullPath),
            fit: BoxFit.cover),
      ),
    );
  }
}
