import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[200]!,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(
                            top: 5, left: 8, right: 8, bottom: 25
                        ),
                        width: 150.0,
                        height: 250,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))
                        )
                    ),
                    Container(
                        width: 150,
                        height: 15,
                        color: Colors.grey
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        width: 120,
                        height: 15,
                        color: Colors.grey
                    )
                  ]
              );
            }
        )
    );
  }
}
