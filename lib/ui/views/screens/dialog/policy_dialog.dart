import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PolicyDialog extends StatelessWidget {

  PolicyDialog({
    Key key,
    this.radius = 8, 
    @required this.mdFileName
    }) : assert(mdFileName.contains('.md')),super(key: key);

  final double radius;
  final String mdFileName;
  

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 100)).then((value) {
                return rootBundle.loadString('assets/$mdFileName');
              }),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data,
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              }
            )
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF3061cc),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius), 
                  bottomRight: Radius.circular(radius),
                ),
              ),
              alignment: Alignment.center,
              height: 50.0,
              width: double.infinity,
              child: Text("Close",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}