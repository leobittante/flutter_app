import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_movie/features/films/presentation/util.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VoteAverageFilms extends StatelessWidget {
  VoteAverageFilms(this.vote_average, {Key? key}) : super(key: key);

  final double vote_average;
  final Util util = Util();

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
              percent: vote_average / 10,
              //progressColor: Theme.of(context).accentColor,
              progressColor: util.progressColorRange(vote_average * 10),
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              center: Text((vote_average * 10)
                  .toInt()
                  .toString() + "%", style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
            )
        )
    );
  }
}
