import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final void Function() onTap;

  const AppointmentCard({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //sfondo della card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff575de3),
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
            //per rendere il container cliccabile ed inserire la funzione onTap
            child: InkWell(
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/doctor01.jpeg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dr.Muhammed Syahid',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Dental Specialist',
                              style: TextStyle(color: Color(0xffbec2fc)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ScheduleCard(),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 20),
        //   width: double.infinity,
        //   height: 10,
        //   decoration: const BoxDecoration(
        //     color: Color(0xffc3c5f8),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black,
        //         blurRadius: 10,
        //         offset: Offset(0, 5),
        //       ),
        //     ],
        //     borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(10),
        //       bottomLeft: Radius.circular(10),
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 40),
        //   width: double.infinity,
        //   height: 10,
        //   decoration: const BoxDecoration(
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black,
        //         blurRadius: 10,
        //         offset: Offset(0, 5),
        //       ),
        //     ],
        //     color: Color(0xffe8eafe),
        //     borderRadius: BorderRadius.only(
        //       bottomRight: Radius.circular(10),
        //       bottomLeft: Radius.circular(10),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff6f75e1),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Mon, July 29',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              '11:00 ~ 12:10',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
