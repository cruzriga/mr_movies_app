import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mr_movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apikey = 'f93b4d9dc6dcb1e8fe644997c1e690ea';
  final String _baseUrl = 'api.themoviedb.org';
  final String _lang = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int popularPage = 0;
  MoviesProvider(){
    print('movies provider init');
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint , [int page = 1]) async {
    var api = Uri.https(_baseUrl, endpoint , {
      'api_key' : _apikey,
      'language': _lang,
      'page'    : '$page'
    });

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
}