import 'package:flutter/material.dart';
import 'package:habit_tracker_2/components/month_summary.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker_2/data/habit_db.dart';
import 'package:habit_tracker_2/components/add_fab.dart';
import 'package:habit_tracker_2/components/habit_tiles.dart';
import 'package:habit_tracker_2/components/my_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//List of Habits
class _HomePageState extends State<HomePage> {
  HabitDb db = HabitDb();
  final _myBox = Hive.box("Habit_DB");

  @override
  void initState() {
    // if it's 1st time opening the app, and no current habit
    // then create default data

    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createData();
    }
    // if not then laod existing data
    else {
      db.loadData();
    }

    //update the db
    db.updateData();

    super.initState();
  }

  //check the checkbox
  void checkboxTapped(bool? val, int index) {
    setState(() {
      db.habitList[index][1] = val;
    });
    db.updateData();
  }

  //create new habit
  final _newHabitController = TextEditingController();
  void makeNewHabit() {
    //show alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          hintText: "Enter Habit Name",
          inputController: _newHabitController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );

    db.updateData();
  }

  //save habit
  void saveNewHabit() {
    //add habits
    setState(() {
      db.habitList.add([_newHabitController.text, false]);
    });

    //clears field
    _newHabitController.clear();

    //close the dialog
    Navigator.pop(context);
    db.updateData();
  }

  //save the changed habit
  void saveEditedHabit(int index) {
    setState(() {
      db.habitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.pop(context);
    db.updateData();
  }

  //pop the dialog
  void cancelDialogBox() {
    //clears field
    _newHabitController.clear();

    //close the dialog
    Navigator.pop(context);
  }

  void openSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          hintText: db.habitList[index][0],
          inputController: _newHabitController,
          onSave: () => saveEditedHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  void deleteHabit(int index) {
    setState(() {
      db.habitList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddFloatingActionButton(
        onPressed: () => makeNewHabit(),
      ),
      backgroundColor: Colors.deepPurple[200],
      body: ListView(
        children: [
          // heatmap
          MonthSummary(datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")),

          //habit list
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: db.habitList.length,
            itemBuilder: (context, index) {
              return HabitTiles(
                habitName: db.habitList[index][0],
                isCompleted: db.habitList[index][1],
                onChanged: (value) => checkboxTapped(value, index),
                settingTapped: (context) => openSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
