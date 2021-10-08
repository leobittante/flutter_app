import 'dart:async'; //TAREFAS ASSINCRONAS
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; //INDICADOR DE PERCENTUAL
import 'package:http/http.dart' as http; //BIBLIOTECA PARA REQUISIÇÕES NA API
import 'dart:core'; //SUBSTRING

void main() async {
  //List<filmModel> list = await buscarFilmes('now_playing');
  runApp(const MyApp());
}

//CLASSE PRINCIPAL - MYAPP
class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Lista de Filmes')
          ),
          body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:   [
                  const Padding(padding: EdgeInsets.all(8),
                      child: Text("Os Mais Populares", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    height: 420,
                    child: listaFilmes('now_playing'),
                  ),
                  const Padding(padding: EdgeInsets.all(8),
                      child: Text("Nos Cinemas", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    height: 400,
                   child: listaFilmes('popular'),
                  )
                ],
              )
          )
      )
    );
  }
}

//CLASSE PARA LISTAR OS FILMES - LAYOUT UNICO - REAPROVEITADO
class listaFilmes extends StatelessWidget {

  String textEndpoint;
  //RECEBE NO CONSTRUTOR A LISTA DE FILMES PARA EXIBIR AO USUARIO
  listaFilmes(this.textEndpoint, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: buscarFilmes(textEndpoint),
        builder:(context, AsyncSnapshot _films) {
          //VALIDA SE OS VALORES DA API CHEGARAM, SE NÃO - APARECE O CARREGAMENTO
          if (!_films.hasData) {
            return const Center(child: CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: Colors.grey,
            ));
          } else {
            return Container(
                margin: const EdgeInsets.all(8),
                child: ListView.builder(
                    itemCount: _films.data.length,
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
                                        image: NetworkImage('https://image.tmdb.org/t/p/original' + _films.data[index].urlImagem)),
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
                                          title: Text(_films.data[index].nome.toString()),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(_films.data[index].overview),
                                                Text('\nLançamento: ' + _formatData(_films.data[index].lancamento)),
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
                                        percent: _films.data[index].nota / 100,
                                        //progressColor: Theme.of(context).accentColor,
                                        progressColor: _progressColorRange(_films.data[index].nota * 10),
                                        circularStrokeCap: CircularStrokeCap.round,
                                        animation: true,
                                        center: Text(_films.data[index].nota.toInt().toString() + "%", style: const TextStyle(fontSize: 14.0, fontFamily: 'Comic Sans MS', fontWeight: FontWeight.bold, color: Colors.white),),
                                      )
                                  )
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 150.0,
                            child: Text(_films.data[index].nome, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),softWrap: true,),
                          ),
                          SizedBox(
                            width: 150.0,
                            child: Text(_formatData(_films.data[index].lancamento), style: const TextStyle(fontSize: 16.0, color: Color.fromRGBO(0, 0, 0, 100) )),
                          ),
                        ],
                      );
                    }
                )
            );
          }
        }
          );
  }
}

//TODA CLASSE ASYNCRONA SERÁ UM RETORNO FUTURO
Future<List<filmModel>> buscarFilmes(String text) async{

  //CRIO O MAPA PARA ENVIAR COMO PARAMETRO NO POST
   Map<String, String> queryParameters =  {
     'api_key': '1019e8ecf4e06f155e24735b9f35f3ab',
     'language': 'pt-BR',
     'page': '2'
   };

   //CRIO A URL DO SERVIDOR E PASSO O MAP COMO PARAMETRO
   var url = Uri.parse('https://api.themoviedb.org/3/movie/' + text).replace(queryParameters: queryParameters);
   //FAÇO O POST E COLETO O RETORNO
   var response = await http.get(url);

   //VALIDO SE A RESPOSTA DO SERVIDOR RETORNOU COM SUCESSO: CODE 200
   if(response.statusCode == 200){
     //DECODIFICO O JSON RETORNADO PELA API
     final json = jsonDecode(response.body);
     //COLOCO EM UMA LISTA O OBJETO "RESULTS" DO SERVIDOR
     final lista = json['results'];

     //CRIO UM OBJETO O NOSSO MODELO DE FILME
     List<filmModel> filmList = [];

     //CRIO O FOR EACH PARA ADICIONARMOS CADA ITEM DA LISTA EM UM OBJETO
     lista.forEach((linha) async {
       var film = filmModel();
       film.id = int.parse(linha['id'].toString());
       film.nome = linha['title'];
       film.urlImagem = linha['poster_path'];
       film.nota = double.parse(linha['vote_average'].toString());
       film.overview = linha['overview'];
       film.nota = film.nota * 10;
       film.lancamento = linha['release_date'];

       //AO CRIAR UM OBJETO FILME MODEL, ADICIONO ELE NA LISTA;
       filmList.add(film);
     });

     //RETORNO A LISTA PARA SER UTILIZADA NO FRONT
     return filmList;

   } else { //CASO DE ERRO AO BUSCAR OS DADOS NO SERVIDOR - RETORNO UMA EXCEPTION
     throw Exception('Falha ao consultar API');
   }
 }

//CLASSE MODELO DE FILMES
class filmModel {

   late String _nome;
   late String _lancamento;
   late String _urlImagem;
   late double _nota;
   late int _id;
   late String _overview;

   @override
  String toString() {
    return 'filmModel{_nome: $_nome, _lancamento: $_lancamento, _urlImagem: $_urlImagem, _nota: $_nota, _id: $_id, _overview: $_overview}';
  }

   String get overview => _overview;

  set overview(String value) {
    _overview = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

   String get lancamento => _lancamento;

  set lancamento(String value) {
    _lancamento = value;
  }

   String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

   double get nota => _nota;

  set nota(double value) {
    _nota = value;
  }

   int get id => _id;

  set id(int value) {
    _id = value;
  }
}

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