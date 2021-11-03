import 'package:flutter/material.dart';
import 'package:list_movie/injection_locator.dart';
import 'package:list_movie/features/films/presentation/pages/home_page.dart';

//CLASSE PRINCIPAL
void main() async {
  init(); //injection
  runApp(const MyApp());
}