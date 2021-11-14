// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mr_movies_app/helpers/Debouncer.dart';
import 'package:mr_movies_app/models/models.dart';
import 'package:mr_movies_app/models/movie_search_resource.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = 'f93b4d9dc6dcb1e8fe644997c1e690ea';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lang = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int popularPage = 0;
  final debouncer = Debouncer(
      duration: const Duration(milliseconds: 500),
  );
  final StreamController <List<Movie>> _suggestStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestStream => _suggestStreamController.stream;

  MoviesProvider(){
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint , [int page = 1, query = '']) async {
    final Map <String,String> data = {
      'api_key' : _apikey,
      'language': _lang,
      'page'    : '$page'
    };

    if(query != '') data['query'] = query;

    final api = Uri.https(_baseUrl, endpoint , data);

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(api);
    return response.body;
  }

  getOnDisplayMovies() async{
    const String endpoint = '/3/movie/now_playing';
    onDisplayMovies = NowPlayingResource.fromJson(await _getJsonData(endpoint)).results;
    notifyListeners();

  }


  getPopularMovies() async{
    const String endpoint = '/3/movie/popular';
    popularPage++;
    final popular = MoviePopularResource.fromJson(await _getJsonData(endpoint, popularPage )).results;
    popularMovies = [...popularMovies, ...popular];
    notifyListeners();
  }

  Future<List<Cast>>getMovieCast(int movieID) async {
    if(moviesCast.containsKey(movieID)) return moviesCast[movieID]!;
    final String endpoint = '/3/movie/$movieID/credits';
    final response = MovieCreditsResource.fromJson(await _getJsonData(endpoint, popularPage ));
    moviesCast[movieID] = response.cast;
    return response.cast;
    notifyListeners();
  }


  Future<List<Movie>> getMovieSearch(String query) async{
    const String endpoint = '/3/search/movie';
    final results = await _getJsonData(endpoint, 1, query);
    return MovieSearchResource.fromJson(results).results;
  }

  void getSuggestionByQuery(String query){
    debouncer.value = '';
    debouncer.onValue = (value) async {
      List<Movie> response = await getMovieSearch(query);
      print(response);
      _suggestStreamController.add(response);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });
    
    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}