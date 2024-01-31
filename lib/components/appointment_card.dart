import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicall/components/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.appointment,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date
    final formattedDate =
        DateFormat('EEEE, d MMMM y', 'it_IT').format(appointment.data);
    // Format the time
    final formattedTime = DateFormat('jm', 'it_IT').format(DateTime(
      appointment.data.year,
      appointment.data.month,
      appointment.data.day,
      appointment.ora.hour,
      appointment.ora.minute,
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
              onTap: onTap,
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
                        const CircleAvatar(
                            //backgroundImage: AssetImage(''),
                            ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appointment.nomeDottore,
                                style: const TextStyle(color: Colors.black)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              appointment.prestazione,
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
