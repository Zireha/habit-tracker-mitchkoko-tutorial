import 'package:habit_tracker_2/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_DB");

class HabitDb {
  List habitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  //create initial data
  void createData() {
    habitList = [
      ["Run", false],
      ["Sleep", false],
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //laod data of exist
  void loadData() {
    //check the day, if it's new day get the habit list from db
    // else just load today list

    if (_myBox.get(todaysDateFormatted()) == null) {
      habitList = _myBox.get("CURRENT_HABIT_LIST");

      //set all completion to false
      for (int i = 0; i < habitList.length; i++) {
        habitList[i][1] = false;
      }
    } else {
      habitList = _myBox.get(todaysDateFormatted());
    }
  }

  //update the selected data
  void updateData() {
    //update today's entry
    _myBox.put(todaysDateFormatted(), habitList);

    //update universal habit list
    //in case it's changed(new, edit, delete)
    _myBox.put("CURRENT_HABIT_LIST", habitList);

    //calculate habits percentage completion
    calculateHabitPercentage();

    //load heatmap
    loadHeatmap();
  }

  void calculateHabitPercentage() {
    int completeCount = 0;
    for (int i = 0; i < habitList.length; i++) {
      if (habitList[i][1] == true) {
        completeCount++;
      }
    }

    String percent =
        habitList.isEmpty
            ? "0.0"
            : (completeCount / habitList.length).toStringAsFixed(1);

    // key => "PERCENTAGE_SUMMARY_YYYYMMDD"
    // value => String of 1dp number between 0.0-1.0 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatmap() {
    DateTime startDate = createDateTimeObject(_myBox.get('START_DATE'));

    //count the number days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentOfEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentOfEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
