import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; //INDICADOR DE PERCENTUAL
import 'dart:core'; //SUBSTRING

//CLASSE PARA LISTAR OS FILMES - LAYOUT UNICO - REAPROVEITADO
class listFilms extends StatefulWidget {
  final List movies;
  const listFilms(this.movies, {Key? key}) : super(key: key);

  @override
  _listFilms createState() => _listFilms();
}

class _listFilms extends State<listFilms> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                itemCount: widget.movies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none, //PROPRIEDADE PARA VAZAR DO LAYOUT
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 8, right: 8, bottom: 25),
                            width: 150.0,
                            height: 250,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/original' +
                                            widget.movies[index].posterPath)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))
                            ), //color: Colors.amber[colorCodes[index]],
                          ),
                          //ADICIONAR A IMAGEM 3 PONTINHOS
                          Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      shape: BoxShape.circle
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.visibility_rounded),
                                    color: Colors.blue,
                                    iconSize: 15,
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                                widget.movies[index].title.toString()),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text(widget.movies[index].overview, style: const TextStyle(fontSize: 14)),
                                                  Text('\nLançamento: ' + _formatData(
                                                      widget.movies[index].releaseDate), style: const TextStyle(fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                              )
                          ),
                          //NOTA DO FILME
                          Positioned(
                              bottom: 2,
                              left: 20,
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: Colors.black87,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircularPercentIndicator(
                                    radius: 40,
                                    lineWidth: 3.0,
                                    animationDuration: 200,
                                    backgroundColor: Colors.black45,
                                    percent: widget.movies[index].voteAverage / 10,
                                    //progressColor: Theme.of(context).accentColor,
                                    progressColor: _progressColorRange(widget
                                        .movies[index].voteAverage * 10),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    animation: true,
                                    center: Text((widget.movies[index].voteAverage * 10)
                                        .toInt()
                                        .toString() + "%", style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),),
                                  )
                              )
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 150.0,
                        child: Text(widget.movies[index].title.toString(),
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                          softWrap: true,),
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Text(_formatData(widget.movies[index].releaseDate),
                            style: const TextStyle(fontSize: 14.0,
                                color: Colors.grey)),
                      ),
                    ],
                  );
                }
            );
  }

//RETORNA A COR DA BARRA DE ACORDO COM A NOTA
  _progressColorRange(double nota) {
    if (nota <= 30) {
      return Colors.redAccent;
    } else if (nota < 70 && nota > 30) {
      return Colors.yellowAccent;
    } else {
      return Colors.blue;
    }
  }

//METODO PARA FORMATAR A DATA DOS FILMES
  String _formatData(text) {
    String ano = text.toString().substring(0, 4);
    String dia = text
        .toString()
        .substring(text
        .toString()
        .length - 2, text
        .toString()
        .length);
    String mes = text.toString().substring(5, 7);

    switch (mes) {
      case '01':
        mes = "jan";
        break;
      case '02':
        mes = "fev";
        break;
      case '03':
        mes = "mar";
        break;
      case '04':
        mes = "abr";
        break;
      case '05':
        mes = "mai";
        break;
      case '06':
        mes = "jun";
        break;
      case '07':
        mes = "jul";
        break;
      case '08':
        mes = "ago";
        break;
      case '09':
        mes = "set";
        break;
      case '10':
        mes = "out";
        break;
      case '11':
        mes = "nov";
        break;
      case '12':
        mes = "dez";
        break;
    }
    return dia + ' de ' + mes + ' de ' + ano;
  }

}