import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicall/components/date_selector.dart';
import 'package:medicall/components/time_selector.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/components/expandable_text.dart';
import 'package:medicall/database/centro_medico.dart';
import 'package:medicall/database/prenotazione_visita.dart';
import 'package:medicall/database/servizio_sanitario.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/main.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/show_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StructureDetails extends StatefulWidget {
  final Centro centro;

  const StructureDetails({Key? key, required this.centro}) : super(key: key);

  @override
  State<StructureDetails> createState() => _StructureDetailsState();
}

class _StructureDetailsState extends State<StructureDetails> {
  int tipo = 0;
  int selectedIndex = -1;
  String nomeTipo = "";
  final timeKey = GlobalKey<TimeSelectorState>();
  final dateKey = GlobalKey<DateSelectorState>();
  late Future<LatLng> currentLocation;
  late Future<SSList?> slist;
  final isTodayNotifier = ValueNotifier<bool>(false);

  // late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

  Future<SSList?> getAllSSCentro() async {
    SSList? list = await APIServices.getSSFromCentro(widget.centro);
    return list;
  }

  Future<LatLng> getPositionCentro() async {
    LatLng position = await getLocationFromAddress(
        "${widget.centro.indirizzo!}, ${widget.centro.citta!}, ${widget.centro.cap!}, ${widget.centro.provincia!}");
    return position;
  }

  @override
  void initState() {
    super.initState();
    currentLocation = getPositionCentro();
    /*   getLocationFromAddress("${widget.centro.indirizzo!}, ${widget.centro.cap!} ${widget.centro.citta!} ${widget.centro.provincia!}")
        .then((location) {
      setState(() {
        currentLocation = location;
      });
    });
  */
    slist = getAllSSCentro();
  }

  @override
  void dispose() {
    super.dispose();
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
                        Text(
                          widget.centro.nome!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder<SSList?>(
                            future: slist,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("");
                              } else if (snapshot.hasData) {
                                final lista = snapshot.data!;
                                return Column(
                                  children: [
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: lista.items!.length,
                                        itemBuilder: (context, index) {
                                          final servizio = lista.items![index];
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(servizio.tipo!,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 16)),
                                            ],
                                          );
                                        }),
                                  ],
                                );
                              }

                              return Text("",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16));
                            }),
                        /*      Text(
                          'Laboratorio di analisi',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                  */
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Descrizione',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            ExpandableText(
                                "${widget.centro.indirizzo!}, ${widget.centro.cap!} ${widget.centro.citta!} ${widget.centro.provincia!}\n\n"
                                "${widget.centro.nome!} ${widget.centro.descrizione!}"),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tipo di Prescrizione',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<SSList?>(
                                future: slist,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text("");
                                  } else if (snapshot.hasData) {
                                    final lista = snapshot.data!;
                                    return SizedBox(
                                        height: 60,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: lista.items!.length,
                                            itemBuilder: (context, index) {
                                              final servizio =
                                                  lista.items![index];
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = index;
                                                    tipo = servizio.idServizio!;
                                                    nomeTipo = servizio.tipo!;
                                                  });
                                                },
                                                child: SizedBox(
                                                  width: 125,
                                                  child: Card(
                                                    child: Center(
                                                        child: Text(
                                                      servizio.tipo!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              selectedIndex ==
                                                                      index
                                                                  ? Colors.blue
                                                                  : Colors
                                                                      .black,
                                                          fontWeight:
                                                              selectedIndex ==
                                                                      index
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .normal),
                                                    )),
                                                  ),
                                                ),
                                              );
                                            }));
                                  }

                                  return const Text("");
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Data appuntamento',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DateSelector(
                              key: dateKey,
                              isTodayNotifier: isTodayNotifier,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Ora appuntamento',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TimeSelector(
                              key: timeKey,
                              isTodayNotifier: isTodayNotifier,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            String orario = timeKey.currentState!.orario;
                            String data = dateKey.currentState!.data;
                            if (data.isNotEmpty &&
                                orario.isNotEmpty &&
                                tipo != 0) {
                              final choose = await showConfirmAppointmentDialog(
                                  context,
                                  data,
                                  orario,
                                  nomeTipo,
                                  widget.centro.nome!);
                              if (choose) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                String? email = prefs.getString("email");
                                String? password = prefs.getString("password");
                                if (email != null && password != null) {
                                  Utente? u = await APIServices.getUtente(
                                      email, password);
                                  Prenotazione p = Prenotazione(
                                      idCm: widget.centro.idCentro,
                                      idUtente: u!.codiceFiscale,
                                      idTipo: tipo,
                                      dataPrenotazione: data,
                                      orario: orario);
                                  APIServices.addPrenotazione(p);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        "Prenotazione effettuata con successo"),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                    dismissDirection: DismissDirection.up,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    margin: EdgeInsets.only(
                                        bottom: size.height - 210,
                                        right: 10,
                                        left: 10),
                                  ));
                                  Navigator.of(context).pop();
                                  CurvedNavigationBarState? state =
                                      bottomNavigationKey.currentState;
                                  state?.setPage(1);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.of(context).pop();
                                }
                              }
                            } else {
                              showMissingAppointmentDetailsDialog(context,
                                  data.isEmpty, orario.isEmpty, tipo == 0);
                            }
                            // Handle confirmation and booking here
                            //print('Data and time confirmed. Booking...');
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
                          child: FutureBuilder<LatLng>(
                              future: currentLocation,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasData) {
                                  final location = snapshot.data!;
                                  return GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                        target: location, zoom: 18),
                                    onMapCreated: (controller) {
                                      addMarker('test', location);
                                    },
                                    markers: _markers.values.toSet(),
                                    myLocationButtonEnabled: false,
                                    myLocationEnabled: false,
                                    zoomControlsEnabled: false,
                                    zoomGesturesEnabled: false,
                                    scrollGesturesEnabled: false,
                                    rotateGesturesEnabled: false,
                                    tiltGesturesEnabled: false,
                                    onTap: (taplocation) {
                                      openGoogleMaps(location.latitude,
                                          location.longitude);
                                    },
                                  );
                                }

                                return const Text("");
                              }),
                          /*           child: GoogleMap(
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
                                   */
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
                    color: AppColors.oro,
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
      List<Location> locations =
          await locationFromAddress(address, localeIdentifier: "it_IT");
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
