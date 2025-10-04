import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker_2/datetime/date_time.dart';

class MonthSummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;
  const MonthSummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 149, 92, 255),
          2: Color.fromARGB(40, 149, 92, 255),
          3: Color.fromARGB(60, 149, 92, 255),
          4: Color.fromARGB(80, 149, 92, 255),
          5: Color.fromARGB(100, 149, 92, 255),
          6: Color.fromARGB(120, 149, 92, 255),
          7: Color.fromARGB(150, 149, 92, 255),
          8: Color.fromARGB(180, 149, 92, 255),
          9: Color.fromARGB(220, 149, 92, 255),
          10: Color.fromARGB(250, 149, 92, 255),
        },
        onClick: (value) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
