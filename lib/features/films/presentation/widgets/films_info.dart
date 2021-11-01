import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util.dart';

//BOTAO DE INFORMAÇÕES DO FILME
class InfoFilms extends StatelessWidget {
  InfoFilms(this.title, this.overview, this.release_date, {Key? key}) : super(key: key);

   final String title;
   final String overview;
   final String release_date;
   final Util util = Util();

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                      title: Text(title),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(overview, style: const TextStyle(fontSize: 14)),
                            Text('\nLançamento: ' + util.formatData(release_date),
                                style: const TextStyle(fontSize: 14)),
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
    );
  }
}
