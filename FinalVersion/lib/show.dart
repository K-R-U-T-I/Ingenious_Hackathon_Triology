import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sampleproject/map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = 'http://10.1.66.39/hackathon/index.php?';
    

class show extends StatelessWidget {
  show({
    @required this.rat,
    this.rat2,
    this.cat,
    this.loc,
    this.t1,
    this.t2,
  });

  final rat2;
  final rat;
  final cat;
  final loc;
  final t1;
  final t2;

  Future<Position> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
       
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('catagory: ' + cat),
            Text('rating1: ' + rat),
            Text('rating2: ' + rat2),
            Text('location: ' + loc),
            Text('x: ' + t1),
            Text('y: ' + t2),
          ],          
        ),
      ),
    );
  
  }

  

  Future getData() async{
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());
  }

}




/* 
Future<http.Response> fetchAlbum() {
  return http.get('http://localhost/hackathon/index.php?category=123&rating1=1&rating2=2&location=12.22&x=12.3334&y=13.4555');
}
*/