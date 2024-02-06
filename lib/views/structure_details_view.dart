import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicall/components/date_selector.dart';
import 'package:medicall/components/time_selector.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/components/expandable_text.dart';
import 'package:url_launcher/url_launcher.dart';

class StructureDetails extends StatefulWidget {
  const StructureDetails({super.key});

  @override
  State<StructureDetails> createState() => _StructureDetailsState();
}

class _StructureDetailsState extends State<StructureDetails> {
  late LatLng currentLocation;

  // late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getLocationFromAddress("Diagnostica Cavallo Srl - Laboratori Analisi")
        .then((location) {
      setState(() {
        currentLocation = location;
      });
    });
    //TODO: rimuovere dopo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0.5, 0),
                end: Alignment(0.5, 1),
                colors: [
              AppColors.bluChiaro,
              AppColors.bluMedio,
              AppColors.bluScuro,
            ])),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.8,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Column(
                      children: [
                        const Text(
                          'Diagnostica Cavallo Srl',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Laboratorio di analisi',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descrizione',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            ExpandableText(
                              "Il laboratorio di analisi Diagnostica Cavallo Srl è un laboratorio di analisi"
                              " cliniche e microbiologiche, con sede a Bari, in viale Einaudi 1. Il laboratorio"
                              " è dotato di attrezzature all’avanguardia e di personale qualificato, in grado di"
                              " garantire un servizio di alta qualità e precisione. Il laboratorio è aperto dal"
                              " lunedì al venerdì dalle 7:30 alle 12:30 e dalle 15:30 alle 18:30, il sabato dalle 7:30 alle 12:30.",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data appuntamento',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DateSelector(),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Ora appuntamento',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TimeSelector(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle confirmation and booking here
                            print('Data and time confirmed. Booking...');
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * 0.9, 50),
                            backgroundColor: Colors.blue.shade900,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Conferma e prenota',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 200,
                          width: size.width * 0.9,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: currentLocation,
                              zoom: 18,
                            ),
                            onMapCreated: (controller) {
                              // _mapController = controller;
                              addMarker('test', currentLocation);
                            },
                            markers: _markers.values.toSet(),
                            myLocationButtonEnabled: false,
                            myLocationEnabled: false,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            scrollGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            onTap: (tapLocation) {
                              openGoogleMaps(currentLocation.latitude,
                                  currentLocation.longitude);
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: size.width / 2 - 65,
              top: size.height * 0.08,
              width: 200,
              child: const Text('Dettagli Struttura',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Positioned(
              left: size.width / 2 - 50,
              top: size.height * 0.2 - 50,
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/cavallo_rounded.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      onTap: () {
        openGoogleMaps(location.latitude, location.longitude);
      },
      // infoWindow: InfoWindow(
      //   title: 'Laboratorio Cavallo',
      //   snippet: 'Laboratorio di analisi',
      //   onTap: () {
      //     openGoogleMaps(location.latitude, location.longitude);
      //   },
      // ),
    );
    _markers[id] = marker;
    setState(() {});
  }

  Future<LatLng> getLocationFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      return LatLng(locations.first.latitude, locations.first.longitude);
    } catch (e) {
      print('Error: ${e.toString()}');
      return const LatLng(0, 0);
    }
  }

  void openGoogleMaps(double latitude, double longitude) async {
    Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open Google Maps';
    }
  }
}
