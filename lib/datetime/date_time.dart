// return formatted days as (YYYYmmDD)
String todaysDateFormatted() {
  var dateTimeObject = DateTime.now();

  //year in yyyy
  String year = dateTimeObject.year.toString();

  //month in mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //day in dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //final format
  String formatted = year + month + day;

  return formatted;
}

DateTime createDateTimeObject(String formatted) {
  int year = int.parse(formatted.substring(0, 4));
  int month = int.parse(formatted.substring(4, 6));
  int day = int.parse(formatted.substring(6, 8));

  DateTime dateTimeObject = DateTime(year, month, day);
  return dateTimeObject;
}

String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }

  String formatted = year + month + day;
  return formatted;
}
