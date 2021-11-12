import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieSliderWidget extends StatelessWidget {
  const MovieSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Populares',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ),
          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (_, index) => const _MoviesPoster()),
          )
        ],
      ),
    );
  }
}

class _MoviesPoster extends StatelessWidget {
  const _MoviesPoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      //  color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://via.placeholder.com/300x400'),
                  fit: BoxFit.cover,
                  width: 130,
                  height: 190,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Star Wars: El retorno del Jedi, la amenaza continua',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
