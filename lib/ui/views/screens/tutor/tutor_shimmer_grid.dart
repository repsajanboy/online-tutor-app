import 'package:flutter/material.dart';

class TutorShimmerGrid extends StatelessWidget {
  const TutorShimmerGrid({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            height: 150.0,
            width: double.infinity,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
            child: Container(
              width: double.infinity,
              height: 10.0,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
                width: double.infinity, height: 20.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
