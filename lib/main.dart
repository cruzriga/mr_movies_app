import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() => runApp(MyApp());

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
