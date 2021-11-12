import 'package:flutter/material.dart';
import 'package:mr_movies_app/widgets/widgets.dart';
// ignore: use_key_in_widget_constructors
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.search_outlined))
          ],

        ),
        body:  SingleChildScrollView(
          child: Column(
            children: const [
              CardSwipperWidget(),
              MovieSliderWidget(),
            ],
          ),
        )
    );
  }
}
