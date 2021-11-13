import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: use_key_in_widget_constructors
class CastingCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, int index) => _CastCard(),
    ),
    );
  }
}
class _CastCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/150X300'),
              fit: BoxFit.cover,
              width: 100,
              height: 140,
            ),
          ),
          const Text(
            'Actor.name sflñskdfñsldf ',
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
