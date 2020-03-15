import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:sampleproject/show.dart';

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
    "Complaints",
    "Feedback",
    "Suggestions",
    "hello",
  ];
  String _category = '';
  final rat = "";
  final cat = "";
  TextEditingController rating = TextEditingController();
  // TextEditingController rating = TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.subject),
                          hintText: 'Rating in 1-5',
                          labelText: 'Rating',
                        ),
                        controller: rating,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          //backend code
                          //navigator remove
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => show(
                                rat: rating.text,
                                cat: _category,
                              ),
                            ),
                          );
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
