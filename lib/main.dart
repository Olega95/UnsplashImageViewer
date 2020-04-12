import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/UIVList.dart';

void main() => runApp(UIViewer());

class UIViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Image Viewer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,

      ),
      home: UIVList(),

    );
  }

}