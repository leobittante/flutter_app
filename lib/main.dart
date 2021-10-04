import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
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
                children:  [
                  const Padding(padding: EdgeInsets.all(8),
                      child: Text("Os Mais Populares", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    height: 420,
                    child: listaFilmes(filmPopulares()),
                  ),
                  const Padding(padding: EdgeInsets.all(8),
                      child: Text("Grátis para Assistir", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(
                    height: 400,
                    child: listaFilmes(filmGratisAssistir()),
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

  //RECEBE NO CONSTRUTOR A LISTA DE FILMES PARA EXIBIR AO USUARIO
  List<filmModel> _films = [];
  listaFilmes(this._films, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
            margin: const EdgeInsets.all(8),
            child: ListView.builder(
                itemCount: _films.length,
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
                                    image: NetworkImage(_films[index].urlImagem)),
                                borderRadius: const BorderRadius.all(Radius.circular(10.0))
                            ), //color: Colors.amber[colorCodes[index]],
                          ),
                          //ADICIONAR A IMAGEM 3 PONTINHOS
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
                               percent: _films[index].nota / 100,
                               //progressColor: Theme.of(context).accentColor,
                               progressColor: _progressColorRange(_films[index].nota),
                               circularStrokeCap: CircularStrokeCap.round,
                               animation: true,
                               center: Text(_films[index].nota.toString() + "%", style: const TextStyle(fontSize: 14.0, fontFamily: 'Comic Sans MS', fontWeight: FontWeight.bold, color: Colors.white),),
                             )
                         )
                         ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 150.0,
                        child: Text(_films[index].nome, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),softWrap: true,),
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Text(_films[index].lancamento, style: const TextStyle(fontSize: 16.0, color: Color.fromRGBO(0, 0, 0, 100) )),
                      ),
                    ],
                  );
                }
            )
        );
  }
}

//RETORNA A COR DA BARRA DE ACORDO COM A NOTA
_progressColorRange(int nota){
  if(nota <= 30){
    return Colors.redAccent;
  } else if (nota < 70 && nota > 30){
    return Colors.yellowAccent;
  } else {
    return Colors.greenAccent;
  }
}

//DEFINIREMOS OS FILMES POPULARES
 filmPopulares(){
   List<filmModel> _films = [];

   //CRIAMOS A LISTA DE FILMES
   filmModel filme1 = filmModel();
   filme1.nome = "Invencível";
   filme1.lancamento = "26 de mar de 2021";
   filme1.urlImagem = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/hXWGbKLfARbfFyMCQ90AQRGjEGo.jpg";
   filme1.nota = 89;

   filmModel filme2 = filmModel();
   filme2.nome = "Ponto Vermelho";
   filme2.lancamento = "11 de fev de 2021";
   filme2.urlImagem = "https://superfilmesonline.pro/wp-content/uploads/2021/03/Ponto-Vermelho.jpg";
   filme2.nota = 59;

   filmModel filme3 = filmModel();
   filme3.nome = "Aves de Rapina: Arlequina e Sua Emancipação Fantabulosa";
   filme3.lancamento = "05 de fev de 2020";
   filme3.urlImagem = "https://www.claquete.com/fotos/filmes/poster/12684_medio.jpg";
   filme3.nota = 71;

   filmModel filme4 = filmModel();
   filme4.nome = "Velozes e Furiosos 9";
   filme4.lancamento = "24 de jun de 2021";
   filme4.urlImagem = "https://br.web.img3.acsta.net/pictures/21/04/14/19/06/3385237.jpg";
   filme4.nota = 87;

   _films.add(filme1);
   _films.add(filme2);
   _films.add(filme3);
   _films.add(filme4);

   return _films;
}

//DEFINIREMOS OS FILMES GRATIS PARA ASSISTIR
filmGratisAssistir(){
  List<filmModel> _films = [];

  //CRIAMOS A LISTA DE FILMES
  filmModel filme1 = filmModel();
  filme1.nome = "Rota de Fuga 3: O Resgate";
  filme1.lancamento = "20 de jun de 2019";
  filme1.urlImagem = "https://media.fstatic.com/wv5kOZw_VRgBDWuRKDhh2BE0rQY=/290x478/smart/media/movies/covers/2019/08/Ai1SOVuB.jpg";
  filme1.nota = 52;

  filmModel filme2 = filmModel();
  filme2.nome = "O Reino Proibido";
  filme2.lancamento = "18 de abr de 2008";
  filme2.urlImagem = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBZnLJC0iZLm9lZqH5055Oq4GP5Ryd0288TTh4ez0Rw7EQbpVmYB6LXyCaAmPiFqlY0F4&usqp=CAU";
  filme2.nota = 65;

  filmModel filme3 = filmModel();
  filme3.nome = "Autodestruição";
  filme3.lancamento = "01 de jun de 2017";
  filme3.urlImagem = "https://www.vejapop.com/img/uploads/500x750/movies/2/230/poster-230.jpg";
  filme3.nota = 47;

  filmModel filme4 = filmModel();
  filme4.nome = "Turks in Space (Dünyayı Kurtaran Adam'ın Oğlu)";
  filme4.lancamento = "14 de dez de 2006";
  filme4.urlImagem = "https://upload.wikimedia.org/wikipedia/en/thumb/0/07/Turks_in_Space.jpg/220px-Turks_in_Space.jpg";
  filme4.nota = 30;

  _films.add(filme1);
  _films.add(filme2);
  _films.add(filme3);
  _films.add(filme4);

  return _films;
}

//CLASSE MODELO DE FILMES
class filmModel {

  late String _nome;
  late String _lancamento;
  late String _urlImagem;
  late int _nota;


  @override
  String toString() {
    return 'filmModel{_nome: $_nome, _lancamento: $_lancamento, _urlImagem: $_urlImagem, _nota: $_nota}';
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

  int get nota => _nota;

  set nota(int value) {
    _nota = value;
  }
}