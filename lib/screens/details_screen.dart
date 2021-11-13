import 'package:flutter/material.dart';
import 'package:mr_movies_app/widgets/casting_card_widget.dart';

// ignore: use_key_in_widget_constructors
class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-data';

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(),
            SliverList(
                delegate: SliverChildListDelegate([
                  _PosterAndTitle(),
                  _Overview(),
                  _Overview(),
                  _Overview(),
                  CastingCardWidget()
                ])),
          ],
        )
    );
  }
}

class _Overview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme =  Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
         const SizedBox(width: 20,),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('Movie.title',style:textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.left,),
             Text('Movie.originalTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
             Row(
               children: [
                 const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                 const SizedBox(width: 5,),
                 Text('Movie.originalTitle', style: textTheme.caption, overflow: TextOverflow.ellipsis),
               ],
             )
           ],
         )
        ],
      ),
      
    );
  }
}

class _CustomAppBar extends StatelessWidget {
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
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: const Text('movie.tile', style: TextStyle(fontSize: 16)),
        ),
        background: const FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage('https://via.placeholder.com/500x300'),
            fit: BoxFit.cover),
      ),
    );
  }
}
