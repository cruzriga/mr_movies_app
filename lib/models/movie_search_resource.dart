// To parse this JSON data, do
//
//     final movieCreditsResource = movieCreditsResourceFromMap(jsonString);

import 'dart:convert';

import 'package:mr_movies_app/models/models.dart';

class MovieSearchResource {
  MovieSearchResource({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory MovieSearchResource.fromJson(String str) => MovieSearchResource.fromMap(json.decode(str));
  factory MovieSearchResource.fromMap(Map<String, dynamic> json) => MovieSearchResource(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );


}

