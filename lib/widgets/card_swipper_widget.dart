import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
class CardSwipperWidget extends StatelessWidget {
  const CardSwipperWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child:Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.54,
        itemHeight: size.height * 0.45,
        itemBuilder: (context, int index){
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: const FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://via.placeholder.com/300x400'),
                  fit: BoxFit.cover
              ),
            ),
          );
        },
      )
    );
  }
}
