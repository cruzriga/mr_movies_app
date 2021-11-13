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
  MoviesProvider(){
    print('movies provider init');
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async{
    var api = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key' : _apikey,
      'language': _lang,
      'page'    : '1'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(api);
    if (response.statusCode == 200) {
     final nowPlaying = NowPlayingResource.fromJson(response.body);
      onDisplayMovies = nowPlaying.results;
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  getPopularMovies() async{
    var api = Uri.https(_baseUrl, '/3/movie/popular', {
      'api_key' : _apikey,
      'language': _lang,
      'page'    : '1'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(api);
    if (response.statusCode == 200) {
      final popular = MoviePopularResource.fromJson(response.body);
      popularMovies = [...popularMovies, ...popular.results];
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}