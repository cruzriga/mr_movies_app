// To parse this JSON data, do
//
//     final moviePopularResource = moviePopularResourceFromMap(jsonString);

import 'dart:convert';

import 'package:mr_movies_app/models/movie_resource.dart';

class MoviePopularResource {
  MoviePopularResource({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory MoviePopularResource.fromJson(String str) => MoviePopularResource.fromMap(json.decode(str));

  factory MoviePopularResource.fromMap(Map<String, dynamic> json) => MoviePopularResource(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}
