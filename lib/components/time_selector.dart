import 'package:flutter/material.dart';

class TimeSelector extends StatefulWidget {
  final ValueNotifier<bool> isTodayNotifier;

  const TimeSelector({super.key, required this.isTodayNotifier});

  @override
  TimeSelectorState createState() => TimeSelectorState();
}

class TimeSelectorState extends State<TimeSelector> {
  int selectedIndex = -1;
  String orario = "";

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isTodayNotifier,
      builder: (context, isToday, child) {
        final times = generateTimes(isToday: isToday);
        return SizedBox(
          height: 55.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    orario = times[selectedIndex];
                  });
                  print('Selected time: ${times[index]}');
                },
                child: SizedBox(
                  width: 80.0,
                  child: Card(
                    child: Center(
                      child: Text(
                        times[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.blue
                              : Colors.black,
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
      },
    );
  }

  List<String> generateTimes({bool isToday = false}) {
    List<String> times = [];
    int startHour = isToday ? DateTime.now().hour + 1 : 8;
    for (int i = startHour; i <= 19; i++) {
      times.add('${i.toString().padLeft(2, '0')}:00');
      if (i != 19) {
        times.add('${i.toString().padLeft(2, '0')}:30');
      }
    }
    return times;
  }
}
