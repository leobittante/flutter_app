import 'package:flutter/cupertino.dart';

class ImgListFilm extends StatelessWidget {
  const ImgListFilm(this.poster_path, {Key? key}) : super(key: key);

  final String poster_path;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 5, left: 8, right: 8, bottom: 25),
      width: 150.0,
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/original' +
                      poster_path)),
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0))
      ), //color: Colors.amber[colorCodes[index]],
    );
  }
}
