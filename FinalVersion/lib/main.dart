import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:gps/gps.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sampleproject/show.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = 'http://10.1.66.39/hackathon/index.php?';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepage(),
      theme: ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF167F67),
      ),
    );
  }
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> _categories = <String>[
    '',
    "Wood Burning",
    "Garbage Burning",
    "Traffic Pollution",
    "Construction Work Pollution",
  ];
  GpsLatlng latlng;

  String address, link;
  String temp1 = "", temp2 = "", ec1, ec2, l1, l2;
  String gatsby;
  double dist, lat, long;
  List<Placemark> placemark;
  String _category = '';
  final rat = "";
  final cat = "";
  final rat2 = "";
  final loc = "";
  final t1 = "";
  final t2 = "";
  TextEditingController rating1 = TextEditingController();
  TextEditingController rating2 = TextEditingController();
  // TextEditingController rating = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void initGps() async {
    var location = Location();
    bool enabled = await location.serviceEnabled();
    if (enabled == false) enabled = await location.requestService();
    if (enabled == true) {
      final gps = await Gps.currentGps();
      latlng = gps;
      String temp = latlng.toString();
      lat = 0.0;
      long = 0.0;
      int i = 0;
      temp1 = "";
      temp2 = "";
      while (temp[i] != ',') {
        temp1 += temp[i];
        i++;
      }
      i += 2;
      while (i != temp.length) {
        temp2 += temp[i];
        i++;
      }
      lat = double.parse(temp1);
      long = double.parse(temp2);
      placemark = await Geolocator().placemarkFromCoordinates(lat, long);
      gatsby = placemark[0].name +
          ", " +
          placemark[0].subLocality +
          ", " +
          placemark[0].locality +
          ", " +
          placemark[0].administrativeArea +
          ", " +
          placemark[0].country +
          " - " +
          placemark[0].postalCode;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => show(
            rat: rating1.text,
            rat2: rating2.text,
            cat: _category,
            loc: gatsby,
            t1: temp1,
            t2: temp2,
          ),
        ),
      );
       url = url + 'category=' + cat.toString() + '&rating1=' + rat.toString() + '&rating2=' + rat2.toString() + '&location=' + loc.toString() + '&x=' + t1.toString() + '&y=' + t2.toString();
        http.Response response = await http.get(url);
        var data = jsonDecode(response.body);
        print('------------------------------------------------------------------------------------------------------------');
        print(data.toString());
    } else
      initGps();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  // key: _formkey,
                  child: Column(
                    children: <Widget>[
                      FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              icon: const Icon(Icons.category),
                              labelText: 'Category*',
                            ),
                            isEmpty: _category == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _category,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _category = newValue;
                                    print(newValue);
                                    state.didChange(newValue);
                                  });
                                },
                                items: _categories.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(
                                      value,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Google-Sans'),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.subject),
                          hintText: 'Rating in 1-10',
                          labelText: 'Rating1',
                        ),
                        controller: rating1,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.subject),
                          hintText: 'Rating in 1-10',
                          labelText: 'Rating2',
                        ),
                        controller: rating2,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          //backend code
                          //navigator remove
                          initGps();
                        },
                        color: Color(0xFF02BB9F),
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
