import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicall/components/appointment.dart';

class AppointmentCard extends StatefulWidget {
  final Appointment appointment;
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  String immagine="";

   String getCentroImage(int id){
    String x = "";
    switch(id){
      case 41:
      x = "assets/images/41.jpg";
      break;

      case 69:
      x= "assets/images/69.png";
      break;

      case 70:
      x = "assets/images/70.jpeg";
      break;

      case 71:
      x = "assets/images/71.jpeg";
      break;

      case 72:
      x = "assets/images/72.png";
      break;

      case 73:
      x = "assets/images/73.jpeg";
      break;

      case 74:
      x = "assets/images/74.jpeg";
      break;

      case 75:
      x = "assets/images/75.jpeg";
      break;

      case 76:
      x = "assets/images/76.jpeg";
      break;

      case 77:
      x = "assets/images/77.jpeg";
      break;

      default:
      x = "assets/images/cavallo_rounded.png";
      break;
    }

    return x;
  }

  @override
  void initState(){
    super.initState();
    immagine = getCentroImage(widget.appointment.idCm!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Format the date
    final formattedDate =
        DateFormat('EEEE, d MMMM y', 'it_IT').format(widget.appointment.dataPrenotazione!);
    // Format the time
    final formattedTime = DateFormat('jm', 'it_IT').format(DateTime(
      widget.appointment.dataPrenotazione!.year,
      widget.appointment.dataPrenotazione!.month,
      widget.appointment.dataPrenotazione!.day,
      widget.appointment.orario!.hour,
      widget.appointment.orario!.minute,
    ));
    return Column(
      children: [
        //sfondo della card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              splashFactory: InkRipple.splashFactory,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // Per allineare gli elementi alla fine uso i container che raggruppano i vari widget
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Non rimuovere il container, serve per allineare gli elementi
                          Container(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          // Non rimuovere il container, serve per allineare gli elementi
                          Container(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.white,
                                  size: 17,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  formattedTime,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32.5,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(immagine,fit: BoxFit.cover))
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.appointment.centroNome!,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              widget.appointment.prescrizione!,
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
