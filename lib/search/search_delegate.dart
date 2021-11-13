import 'package:flutter/material.dart';
import 'package:mr_movies_app/models/movie_resource.dart';
import 'package:mr_movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  String get searchFieldLabel => 'Buscar película';
  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
     IconButton(
         onPressed: () => query = '' ,
         icon: const Icon(Icons.clear)
     )
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return  IconButton(
       onPressed: (){
        close(context, null);
       },
       icon: const Icon(Icons.arrow_back)
   );
  }

  @override
  Widget buildResults(BuildContext context) {
   return Text('uno');
  }
  Widget ContainerEmpty(){
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38, size: 100,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return ContainerEmpty();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieSearch(query),
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return ContainerEmpty();
        }
        final List<Movie> movies = snapshot.data!;
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, index){
              final Movie movie = movies[index];
              movie.heroId = 'search-${movie.id}';
              return ListTile(
                leading: Hero(
                  tag: movie.heroId!,
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg') ,
                    image: NetworkImage(movie.posterFullPath),
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  Navigator.pushNamed(context, 'details', arguments: movie);
                },
              );
            }
        );
      },
    );
  }
}