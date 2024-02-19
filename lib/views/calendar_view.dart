import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/components/appointment.dart';
import 'package:medicall/components/appointment_card.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/main.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<AppointmentList?> appList;

  Future<AppointmentList?> getAllAppuntamenti() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");
    if (email != null && password != null) {
      Utente? u = await APIServices.getUtente(email, password);
      AppointmentList? apps = await APIServices.getAppointmentsFromUtente(u!);
      return apps;
    }

    return null;
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'In programma'),
    Tab(text: 'Passate'),
  ];

  @override
  void initState() {
    super.initState();
    appList = getAllAppuntamenti();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Le mie visite',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs,
            // cambia la grandezza dell'indicatore
            indicatorSize: TabBarIndicatorSize.tab,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            CurvedNavigationBarState? state = bottomNavigationKey.currentState;
            state?.setPage(2);
          },
          extendedPadding: const EdgeInsets.symmetric(horizontal: 10),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.bluChiaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          icon: const Icon(Icons.edit),
          label: const Text('Prenota visita'),
          extendedTextStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder<AppointmentList?>(
            future: appList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Padding(padding: EdgeInsets.only(top: 230)),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())
                    ]));
              } else if (snapshot.hasData) {
                final appuntamenti = snapshot.data!;
                return TabBarView(
                  controller: _tabController,
                  children: [
                    Tab1(appointments: appuntamenti.items!),
                    Tab2(appointments: appuntamenti.items!)
                  ],
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          SvgPicture.asset(
                            ImageConstant.prescriptionImage,
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Organizza le tue visite",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                                "Tieni traccia delle tue visite e degli appuntamenti con i tuoi medici per non dimenticarli mai più!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400)),
                          )
                        ]))
                  ],
                );
              }
            })
        /* TabBarView(
        controller: _tabController,
        children: [
          Tab1(appointments: ),
          Tab2(appointments: appointments),
        ],
      ),
    */
        );
  }
}

class Tab1 extends StatelessWidget {
  final List<Appointment> appointments;

  const Tab1({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final futureAppointments = appointments.where((appointment) {
      final datex = DateTime(
          appointment.dataPrenotazione!.year,
          appointment.dataPrenotazione!.month,
          appointment.dataPrenotazione!.day,
          appointment.orario!.hour,
          appointment.orario!.minute);
      return datex.isAfter(DateTime.now());
    }).toList();

    return futureAppointments.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: futureAppointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: AppointmentCard(
                  appointment: futureAppointments[index],
                  onTap: () {

                  },
                ),
              );
            },
          )
        : Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageConstant.calendarImage,
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Organizza le tue visite',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Tieni traccia delle tue visite e degli appuntamenti con i tuoi medici per non dimenticarli mai più!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    //const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
  }
}

class Tab2 extends StatelessWidget {
  final List<Appointment> appointments;

  const Tab2({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final pastAppointments = appointments.where((appointment) {
      final datax = DateTime(
          appointment.dataPrenotazione!.year,
          appointment.dataPrenotazione!.month,
          appointment.dataPrenotazione!.day,
          appointment.orario!.hour,
          appointment.orario!.minute);
      return datax.isBefore(DateTime.now());
    }).toList();

    return pastAppointments.isNotEmpty
        ? ListView.builder(
            itemCount: pastAppointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: AppointmentCard(
                  appointment: pastAppointments[index],
                  onTap: () {},
                ),
              );
            },
          )
        : Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageConstant.calendarImage,
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Organizza le tue visite',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Tieni traccia delle tue visite e degli appuntamenti con i tuoi medici per non dimenticarli mai più!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    //const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
  }
}
