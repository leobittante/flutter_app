import 'package:flutter/material.dart';
import 'package:list_movie/Bloc/film_search_bloc.dart';
import 'package:list_movie/Model/film_model.dart';
import 'package:percent_indicator/percent_indicator.dart'; //INDICADOR DE PERCENTUAL
import 'dart:core'; //SUBSTRING

//CLASSE PARA LISTAR OS FILMES - LAYOUT UNICO - REAPROVEITADO
class listaFilmes extends StatefulWidget {
  final String textEndpoint;
  const listaFilmes(this.textEndpoint, {Key? key}) : super(key: key);

  @override
  _listaFilmes createState() => _listaFilmes();
}

class _listaFilmes extends State<listaFilmes> {

  @override
  Widget build(BuildContext context) {
    //ARRUMAR A VARIAVEL FIXA
    FilmSearch filmSearchBloc = FilmSearch();
    filmSearchBloc.input.add('now_playing');

    return Container(
        margin: const EdgeInsets.all(8),
        child: StreamBuilder<List<FilmModel>>(
            stream: filmSearchBloc.output,
            builder: (context, _films){
              return ListView.builder(
                  itemCount: _films.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none, //PROPRIEDADE PARA VAZER DO LAYOUT
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 25),
                              width: 150.0,
                              height: 250,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage('https://image.tmdb.org/t/p/original' + _films.data![index].posterPath)),
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0))
                              ), //color: Colors.amber[colorCodes[index]],
                            ),
                            //ADICIONAR A IMAGEM 3 PONTINHOS
                            Positioned(
                                top: 2,
                                right: 5,
                                child: IconButton(
                                  icon: const Icon(Icons.youtube_searched_for_sharp),
                                  color: Colors.deepOrangeAccent,
                                  iconSize: 30,
                                  onPressed: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(_films.data![index].title.toString()),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(_films.data![index].overview),
                                                Text('\nLançamento: ' + _formatData(_films.data![index].releaseDate)),
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
                            ),
                            //NOTA DO FILME
                            Positioned(
                                bottom: 2,
                                left: 20,
                                child: Container (
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
                                      percent: _films.data![index].voteAverage / 10,
                                      //progressColor: Theme.of(context).accentColor,
                                      progressColor: _progressColorRange(_films.data![index].voteAverage * 10),
                                      circularStrokeCap: CircularStrokeCap.round,
                                      animation: true,
                                      center: Text((_films.data![index].voteAverage * 10).toInt().toString()  + "%", style: const TextStyle(fontSize: 14.0, fontFamily: 'Comic Sans MS', fontWeight: FontWeight.bold, color: Colors.white),),
                                    )
                                )
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 150.0,
                          child: Text(_films.data![index].title.toString(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),softWrap: true,),
                        ),
                        SizedBox(
                          width: 150.0,
                          child: Text(_formatData(_films.data![index].releaseDate), style: const TextStyle(fontSize: 16.0, color: Color.fromRGBO(0, 0, 0, 100) )),
                        ),
                      ],
                    );
                  }
              );
            }
        )
    );
    throw UnimplementedError();
  }

}
  //RECEBE NO CONSTRUTOR A LISTA DE FILMES PARA EXIBIR AO USUARIO


//RETORNA A COR DA BARRA DE ACORDO COM A NOTA
_progressColorRange(double nota){
  if(nota <= 30){
    return Colors.redAccent;
  } else if (nota < 70 && nota > 30){
    return Colors.yellowAccent;
  } else {
    return Colors.greenAccent;
  }
}

//METODO PARA FORMATAR A DATA DOS FILMES
String _formatData(text){

  String ano = text.toString().substring(0, 4);
  String dia = text.toString().substring(text.toString().length -2, text.toString().length);
  String mes = text.toString().substring(5, 7);

  switch(mes) {
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