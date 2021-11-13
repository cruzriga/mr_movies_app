import 'package:flutter/material.dart';
import 'package:mr_movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(AppState());

// ignore: use_key_in_widget_constructors
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false,),
      ],
      child: MyApp(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mr Movies',
      home: HomeScreen(),
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo
        )
      ),
      routes: {
        'home': ( _ ) =>  HomeScreen(),
        'details' : ( _ ) => DetailsScreen()
      },
    );
  }
}

