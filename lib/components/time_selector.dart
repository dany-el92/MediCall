import 'package:flutter/material.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({super.key});

  @override
  TimeSelectorState createState() => TimeSelectorState();
}

class TimeSelectorState extends State<TimeSelector> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final times = generateTimes();
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

  List<String> generateTimes() {
    List<String> times = [];
    for (int i = 8; i <= 19; i++) {
      times.add('${i.toString().padLeft(2, '0')}:00');
      if (i != 19) {
        times.add('${i.toString().padLeft(2, '0')}:30');
      }
    }
    return times;
  }
}
