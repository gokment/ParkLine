import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Const/const.dart';
import 'package:parkline/Screens/Log_And_Sign/login_screen.dart';
import 'package:parkline/Widgets/Drawer_Widget.dart';
import 'package:parkline/Widgets/buildSheet.dart';
import 'package:parkline/Widgets/long_filter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController mapController;
  Color carColor = Colors.orange;
  Color bikeColor = kblack;
  bool isCar = false;
  bool isMoto = true;

  final Geolocator _geolocator = Geolocator();
  Position _currentPosition;

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    getMarkerData();
    _getCurrentLocation();
    _createPolylines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueAccent),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text("ParkLine"),
        title: Text(
          "ParkLine",
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              // mapType: MapType.satellite,
              markers: Set<Marker>.of(markers.values),
              polylines: Set<Polyline>.of(polylines.values),
              // polylines: poline,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                getMarkerData();
              },
              initialCameraPosition: CameraPosition(
                target: const LatLng(7.369722, 12.354722),
                zoom: 2,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        // margin: EdgeInsets.only(top: 810, right: 330),
        // margin: EdgeInsets.only(top: 200, right: 10),
        margin: EdgeInsets.only(top: 500, right: 10),
        alignment: Alignment.topRight,
        child: Column(
          children: [
            Card(
              elevation: 10.0,
              color: korange,
              // color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: IconButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: Icon(FontAwesomeIcons.compass, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(specify["coords"].latitude, specify["coords"].longitude),
        infoWindow: InfoWindow(
          title: specify["place"],
          snippet: specify["place"],
          onTap: () {
            // Navigator.push(
            // context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
        onTap: () {
          print(specify["markerID"]);
          showModalBottomSheet(
              // enableDrag: false,
              // isDismissible: false,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return BuildSheetWidget(passedName: specify);
                // makeDismissible(
                //   child: DraggableScrollableSheet(
                //     initialChildSize: 0.7,
                //     minChildSize: 0.5,
                //     maxChildSize: 0.7,
                //     builder: (_, controller) => Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.vertical(
                //           top: Radius.circular(30),
                //         ),
                //       ),
                //       padding: EdgeInsets.all(16),
                //       child: ListView(
                //         controller: controller,
                //         children: [
                //           Text(
                //             "Hi Dominique",
                //             style: TextStyle(
                //                 fontFamily: 'Montserrat',
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 18.0),
                //           ),
                //           Text(
                //             "Do you want to park at ${specify["place"]} ?",
                //             style: TextStyle(
                //                 fontFamily: 'Montserrat',
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 18.0),
                //           ),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: <Widget>[
                //               Container(
                //                 child: Text(
                //                   "Choose your vehicule type",
                //                   style: TextStyle(
                //                       fontFamily: 'Montserrat',
                //                       fontWeight: FontWeight.w900,
                //                       fontSize: 18.0),
                //                 ),
                //               ),
                //               Container(
                //                 height: MediaQuery.of(context).size.height / 18,
                //                 width: MediaQuery.of(context).size.width / 8,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   border: Border.all(color: Colors.blueAccent),
                //                 ),
                //                 child: IconButton(
                //                   icon: isMoto ? Icon(
                //                     FontAwesomeIcons.motorcycle,
                //                     color: carColor,
                //                   ):Icon(
                //                     FontAwesomeIcons.motorcycle,
                //                     color: kblack,
                //                   ),
                //                   onPressed: () {
                //                     // Routes.accountScreenNavigator(context);
                //                     setState(
                //                       () {
                //                         isMoto = true;
                //                         isCar = false;
                //                         bikeColor = Colors.orange;
                //                         carColor = kblack;
                //                       },
                //                     );
                //                     print(isMoto);
                //                   },
                //                 ),
                //               ),
                //               Container(
                //                 height: MediaQuery.of(context).size.height / 18,
                //                 width: MediaQuery.of(context).size.width / 8,
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   border: Border.all(color: Colors.blueAccent),
                //                 ),
                //                 child: IconButton(
                //                   icon:isCar ? Icon(
                //                     FontAwesomeIcons.car,
                //                     color: carColor,
                //                   ):Icon(
                //                     FontAwesomeIcons.car,
                //                     color: kblack,
                //                   ),
                //                   onPressed: () {
                //                     print(isCar);
                //                     setState(
                //                       () {
                //                         isMoto = false;
                //                         isCar = true;
                //                         carColor = Colors.orange;
                //                         bikeColor = kblack;
                //                       },
                //                     );
                //                   },
                //                 ),
                //               ),
                //             ],
                //           ),
                //           SizedBox(
                //             height: 8.0,
                //           ),
                //           Divider(
                //             color: Colors.grey,
                //           ),
                //           SizedBox(
                //             height: 25.0,
                //           ),
                //           LongFilterWidget(),
                //           SizedBox(
                //             height: 25.0,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 left: 20.0, right: 20.0, top: 20.0),
                //             child: InkWell(
                //               onTap: () {
                //                 print("object");
                //               },
                //               child: Container(
                //                 width: 20.0,
                //                 padding: EdgeInsets.symmetric(
                //                     horizontal: 30.0, vertical: 20),
                //                 decoration: BoxDecoration(
                //                     color: Colors.blueAccent,
                //                     borderRadius: BorderRadius.circular(7.0)),
                //                 child: Center(
                //                   child: Text(
                //                     "CONFIRM",
                //                     style: TextStyle(
                //                         fontSize: 16.0, color: Colors.white),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // );
              });
        });
    setState(
      () {
        markers[markerId] = marker;
      },
    );
  }

  getMarkerData() async {
    Firestore.instance.collection('markers').getDocuments().then((myMocData) {
      if (myMocData.documents.isNotEmpty) {
        for (int i = 0; i < myMocData.documents.length; i++) {
          initMarker(
            myMocData.documents[i].data(),
            myMocData.documents[i].documentID,
          );
        }
      }
    });
  }

  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordonates = [];
  Map<PolylineId, Polyline> polylines = {};

  _createPolylines() async {
    polylinePoints = PolylinePoints();
    const DEST_LOCATION = LatLng(7.369722, 12.354722);
    const destination = LatLng(7.369722, 13.354722);
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyD1LmW98oZCmkr_Ubx3Koaj2DCrIfvRRkk",
      PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordonates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId('poly');

    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordonates,
      width: 5,
    );
    polylines[id] = polyline;
  }

  Widget makeDismissible({Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
