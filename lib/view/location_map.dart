import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationOnMap extends StatefulWidget {
  const LocationOnMap({Key? key}) : super(key: key);

  @override
  State<LocationOnMap> createState() => _LocationOnMapState();
}

class _LocationOnMapState extends State<LocationOnMap> {
  LatLng initialPosition = LatLng(0, 0);
  CameraPosition initialCameraPosition =
      CameraPosition(zoom: 15, target: LatLng(0, 0));

  LatLng currentLocation = LatLng(0, 0);
  late GoogleMapController mapController;
  String address = "";

  List<Marker> markers = <Marker>[
    Marker(
      draggable: true,
      markerId: MarkerId("1"),
      position: LatLng(0, 0),
      icon: BitmapDescriptor.defaultMarker,
    )
  ];

  void _updatePosition(CameraPosition _position) {
    LatLng newMarkerPosition =
        LatLng(_position.target.latitude, _position.target.longitude);

    Marker marker = markers[0];

    setState(() {
      markers[0] = marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
      currentLocation = newMarkerPosition;
    });
  }

  Future<void> getAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);

    Placemark placeMark = placemarks[0];
    String name = placeMark.name!;
    String subLocality = placeMark.subLocality!;
    String locality = placeMark.locality!;
    String administrativeArea = placeMark.administrativeArea!;
    String postalCode = placeMark.postalCode!;
    String country = placeMark.country!;
    String fullAddress = "${country}, ${locality}, ${subLocality}";
    //"${country}, ${administrativeArea}, ${locality}, ${subLocality} ${postalCode}";
    //"${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(fullAddress);

    setState(() {
      address = fullAddress;
    });
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      initialPosition = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(initialPosition.latitude, initialPosition.longitude),
          zoom: 15,
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

// Shipping Address
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        //backgroundColor: Colors.pink,

        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Checkout',
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                markers: markers.toSet(),
                initialCameraPosition: initialCameraPosition,
                mapType: MapType.normal,
                onCameraMove: ((_position) => _updatePosition(_position)),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  _getUserLocation();
                },
                myLocationEnabled: true,
              ),
            ),
          ),
          Container(
            //color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 5, // Space between underline and text
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color.fromARGB(255, 0, 129, 172),
                    width: 1.0, // Underline thickness
                  ))),
                  child: Text(
                    'Shipping Address',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Text('Summary & Payment')
              ],
            ),
            decoration: BoxDecoration(
                //color: Colors.blueGrey,
                border: Border(
                    bottom: BorderSide(
              color: Color.fromARGB(30, 0, 0, 0),
              width: 1,
            ))),
          ),
          Positioned.fill(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: () async {
                    await Update();

                    Navigator.pop(context);
                  },
                  child: Text('confirm location'),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: MediaQuery.of(context).size.width / 2,
                  color: Color.fromARGB(255, 0, 0, 0),
                  textColor: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  Future<void> Update() async {
    await getAddress();
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    // Update
    docUser.update({
      'location': address,
    });
    setState(() {});
  }
}
