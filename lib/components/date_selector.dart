import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => DateSelectorState();
}

class DateSelectorState extends State<DateSelector> {
  int selectedIndex = -1;

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
              });
              print('Selected date: ${dates[index]}');
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
