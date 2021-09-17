import 'package:flutter/material.dart';

class TutorShimmerList extends StatelessWidget {
  const TutorShimmerList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
      margin: const EdgeInsets.fromLTRB(13, 5, 13, 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(40))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  height: 10.0,
                  color: Colors.grey,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .25,
                  margin: EdgeInsets.only(left: 20),
                  height: 10.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
        Container(
            color: Colors.grey,
            height: 30.0,
            width: MediaQuery.of(context).size.width * .4,
            margin: EdgeInsets.only(bottom: 10.0, top: 10.0)),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 10.0,
          width: MediaQuery.of(context).size.width * .25,
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 10.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 10.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 10.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          height: 10.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        )
      ]),
    );
  }
}
