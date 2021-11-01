import 'package:flutter/material.dart';
import 'package:list_movie/features/films/domain/entities/response_film_entity.dart';
import 'package:list_movie/features/films/presentation/widgets/films_info.dart';
import 'package:list_movie/features/films/presentation/widgets/films_vote_average.dart';
import 'dart:core';
import '../util.dart';
import 'films_img_list.dart'; //SUBSTRING

//CLASSE PARA LISTAR OS FILMES - LAYOUT UNICO - REAPROVEITADO
class listFilms extends StatefulWidget {
  ResponseFilmEntity movies;
  listFilms(this.movies, {Key? key}) : super(key: key);

  @override
  _listFilms createState() => _listFilms();
}

class _listFilms extends State<listFilms> {
  final Util util = Util();

  @override
  Widget build(BuildContext context) {
    final movies = widget.movies;

    return ListView.builder(
        itemCount: movies.results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none, //PROPRIEDADE PARA VAZAR DO LAYOUT
                children: <Widget>[
                  //WIDGET: IMAGEM DO FILME
                  ImgListFilm(movies.results[index].posterPath.toString()),

                  //WIDGET: INFORMAÇÕES DO FILME
                  InfoFilms(
                      movies.results[index].title.toString(),
                      movies.results[index].overview.toString(),
                      movies.results[index].releaseDate.toString()),

                  //NOTA DO FILME
                  VoteAverageFilms(
                      movies.results[index].voteAverage!.toDouble())
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 150.0,
                child: Text(
                  movies.results[index].title.toString(),
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              SizedBox(
                width: 150.0,
                child: Text(util.formatData(movies.results[index].releaseDate),
                    style: const TextStyle(fontSize: 14.0, color: Colors.grey)),
              ),
            ],
          );
        });
  }
}
