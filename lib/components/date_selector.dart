import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final ValueNotifier<bool> isTodayNotifier;

  const DateSelector({super.key, required this.isTodayNotifier});

  @override
  State<DateSelector> createState() => DateSelectorState();
}

class DateSelectorState extends State<DateSelector> {
  int selectedIndex = -1;
  String data = "";

  @override
  Widget build(BuildContext context) {
    final dates = generateCurrentMonthDates();
    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          String dayOfWeek = DateFormat('EEE', 'it_IT').format(dates[index]);
          String capitalizedDayOfWeek =
              dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                data = dates[selectedIndex].toString().split(" ")[0];
              });
              print('Selected date: ${dates[index]}');
              if (dates[index].day == DateTime.now().day &&
                  dates[index].month == DateTime.now().month &&
                  dates[index].year == DateTime.now().year) {
                widget.isTodayNotifier.value = true;
              } else {
                widget.isTodayNotifier.value = false;
              }
            },
            child: SizedBox(
              width: 65.0,
              child: Card(
                child: Center(
                  child: Text(
                    '$capitalizedDayOfWeek\n${dates[index].day}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          selectedIndex == index ? Colors.blue : Colors.black,
                      fontWeight: selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> generateCurrentMonthDates() {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    return List<DateTime>.generate(daysInMonth - now.day + 1,
        (i) => DateTime(now.year, now.month, now.day + i));
  }
}
