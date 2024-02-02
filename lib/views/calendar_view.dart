import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/components/appointment.dart';
import 'package:medicall/components/appointment_card.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/constants/images.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'In programma'),
    Tab(text: 'Passate'),
  ];

  @override
  void initState() {
    super.initState();
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
        onPressed: () {},
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
      body: TabBarView(
        controller: _tabController,
        children: const [
          Tab1(),
          Tab2(),
        ],
      ),
    );
  }
}

class Tab1 extends StatelessWidget {
  const Tab1({super.key});

  static final List<Appointment> appointments = [
    Appointment(
      nomeDottore: 'Dr. Daniele Gregori',
      prestazione: 'Ortopedia',
      data: DateTime(2024, 06, 1),
      ora: const TimeOfDay(hour: 10, minute: 30),
    ),
    Appointment(
      nomeDottore: 'Dr. Samuele Antonio Cesaro',
      prestazione: 'Cardiologo',
      data: DateTime(2024, 11, 20),
      ora: const TimeOfDay(hour: 12, minute: 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Your code for Tab 1 goes here
    return appointments.isNotEmpty
        ? ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: AppointmentCard(
                  appointment: appointments[index],
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

class Tab2 extends StatelessWidget {
  const Tab2({super.key});

  static final List<Appointment> appointments = [
    // Appointment(
    //   nomeDottore: 'Dr. Daniele Gregori',
    //   prestazione: 'Ortopedia',
    //   data: DateTime(2024, 06, 1),
    //   ora: const TimeOfDay(hour: 10, minute: 30),
    // ),
    // Appointment(
    //   nomeDottore: 'Dr. Samuele Antonio Cesaro',
    //   prestazione: 'Cardiologo',
    //   data: DateTime(2024, 11, 20),
    //   ora: const TimeOfDay(hour: 12, minute: 30),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    // Your code for Tab 2 goes here
    return appointments.isNotEmpty
        ? ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: AppointmentCard(
                  appointment: appointments[index],
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
