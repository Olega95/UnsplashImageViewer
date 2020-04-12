import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/UIVData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UIVList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return UIVListState();
  }
}

class UIVListState extends State<UIVList> {
  List<UIVData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsplash Image Viewer')
      ),
      body: ListView(
        children: _buildList()
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC()
      )
    );
  }

  _loadCC() async{
    final response = await http.get('https://api.unsplash.com/photos/random/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9&count=30');
    if(response.statusCode == 200) {
      var allData = json.decode(response.body);
      var uivDataList = List<UIVData>();
      for (var o in allData) {
        var record = UIVData(
            author: o['user']['name'],
            description: o['alt_description'],
            image: o['urls']['thumb'],
            avatar: o['user']['profile_image']['large'],
            largeImage: o['urls']['regular']
        );
        uivDataList.add(record);
      }
      setState(() {
        data = uivDataList;
      });
    }

}

  List<Widget> _buildList() {
    return data.map((UIVData f) => Container(
        margin: EdgeInsets.only(right: 1, top: 2, bottom: 2),
        child: ListTile(
          subtitle: Text(
              f.description != null ? (f.description
                  .substring(0, 1)
                  .toUpperCase() + (f.description.substring(1))) : 'No Description',
            textAlign: TextAlign.justify,
          ),
          title: Text(f.author.toUpperCase()),
          trailing: ClipRRect(
            child: Image.network(f.image, width: 90, height: 50, fit: BoxFit.cover,),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(f.avatar),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Image.network(f.largeImage,
                  ),
              ),
            );
          },
        ))).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCC();
  }
}