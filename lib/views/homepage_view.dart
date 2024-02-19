import 'dart:async';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicall/components/appointment.dart';
import 'package:medicall/components/appointment_card.dart';
import 'package:medicall/components/assistant_card.dart';
import 'package:medicall/constants/images.dart';
import 'package:medicall/database/centro_medico.dart';
import 'package:medicall/database/utente.dart';
import 'package:medicall/main.dart';
import 'package:medicall/utilities/api_services.dart';
import 'package:medicall/utilities/extensions.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/views/structure_details_view.dart';

const Duration debounceDuration = Duration(milliseconds: 500);

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}

class HomePageView extends StatefulWidget {
  final Utente utente;

  const HomePageView({Key? key, required this.utente}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String? currentQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];
  late _Debounceable<CentroList?, String> _debouncedSearch;
  late Future<Appointment?> todayapp;

  Future<Appointment?> checkTodaysAppointment() async {
    Appointment? a = await APIServices.getTodaysAppointment(widget.utente.codiceFiscale!);
    return a;
  }

  Future<CentroList?> searchCentro(String query) async {
    currentQuery = query;
    CentroList? options;

    if (currentQuery!.isEmpty) {
      return CentroList(items: []);
    } else {
      options = await APIServices.getCentriFromSearchBar(query.toLowerCase());
    }

    if (currentQuery != query) {
      return null;
    }

    currentQuery = null;

    return options;
  }

  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<CentroList?, String>(searchCentro);
    todayapp = checkTodaysAppointment();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ciao,',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "${widget.utente.nome} ${widget.utente.cognome} 👋",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent.shade700,
                  child: Text(
                      "${widget.utente.nome![0]}${widget.utente.cognome![0]}",
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            SearchAnchor(
                viewSurfaceTintColor: Colors.white,
                textCapitalization: TextCapitalization.words,
                viewLeading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () async {
                      Navigator.pop(context);
                      await Future.delayed(
                        const Duration(milliseconds: 100),
                        () => FocusManager.instance.primaryFocus?.unfocus(),
                      );
                    }),
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    surfaceTintColor: MaterialStateProperty.all(Colors.white),
                    shadowColor: MaterialStateProperty.all(AppColors.bluChiaro),
                    hintText: "Trova strutture sanitarie",
                    hintStyle: MaterialStateProperty.all(const TextStyle(
                        fontSize: 15,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal)),
                    leading: const Icon(Icons.search,
                        size: 30, color: AppColors.bluChiaro),
                    elevation: MaterialStateProperty.all(4.0),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) async {
                  final centrolist = await _debouncedSearch(controller.text);

                  if (centrolist == null) {
                    return _lastOptions;
                  }

                  _lastOptions = List<ListTile>.generate(
                      centrolist.items!.length, (int index) {
                    final String item = centrolist.items![index].nome!;
                    return ListTile(
                      leading: const Icon(Icons.local_hospital),
                      title: Text(item),
                      trailing: const Icon(Icons.arrow_outward),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StructureDetails(
                                centro: centrolist.items![index])));
                      },
                    );
                  });

                  return _lastOptions;
                }),
            /*        ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 30,
                color: AppColors.bluChiaro,
              ),
              label: const Text(
                'Trova strutture sanitarie',
                style: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerLeft,
                backgroundColor: Colors.white,
                fixedSize: Size(size.width * 0.95, size.height * 0.06),
                elevation: 4,
                shadowColor: AppColors.bluChiaro,
                surfaceTintColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
    */
            SizedBox(height: size.height * 0.05),
            const Text(
              "Prenota una visita tramite l'Assistente Virtuale",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              height: size.height * 0.60,
              child: Card(
                elevation: 10,
                shadowColor: AppColors.bluChiaro,
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(ImageConstant.chatImage, width: 200),
                      const Text(
                        "Chiedi aiuto all'Assistente",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        "Utilizza l'Assistente Virtuale per prenotare una visita senza dover attendere in coda."
                        " Chiedi al tuo assistente di prenotare una visita e lui ti guiderà passo passo.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          wordSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const AssistantCard(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Prossimo Appuntamento',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    )),
                TextButton(
                  child: Text(
                    'Vedi Tutti',
                    style: TextStyle(
                      color: Colors.amber.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    CurvedNavigationBarState? state =
                        bottomNavigationKey.currentState;
                    state?.setPage(1);
                  },
                )
              ],
            ),
            FutureBuilder<Appointment?>(
                future: todayapp,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 50)),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator())
                      ],
                    );
                  } else if (snapshot.hasData) {
                    final appuntamento = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: AppointmentCard(
                        appointment: appuntamento,
                        onTap: () {
                        //  Centro? c = await APIServices.getCentrofromId(appuntamento.idCm!);
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppointmentDataView(centro: c!, idVisita: appuntamento.idVisita!,)));
                        },
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(right: 65, top: 15),
                      child: Text(
                        "Non sono previsti appuntamenti programmati",
                        style: TextStyle(
                            fontSize: 15,
                            wordSpacing: 1.0,
                            fontWeight: FontWeight.normal),
                      ),
                    );
                  }
                }),

            /*   AppointmentCard(
              appointment: Appointment(
                centroNome: 'Dr. Daniele Gregori',
                prescrizione: 'Ortopedia',
                dataPrenotazione: DateTime(2024, 06, 1),
                orario: const TimeOfDay(hour: 10, minute: 30),
              ),
              onTap: () {},
            ),
        */
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
