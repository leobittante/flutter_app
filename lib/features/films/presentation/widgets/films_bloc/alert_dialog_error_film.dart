import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorFilmAlertDialog extends StatelessWidget {
  const ErrorFilmAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erro ao Listar os Filmes'),
      content: const Text(
          'Não foi possível listar os filmes. Por favor, tente novamente!'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
