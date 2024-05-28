import 'package:intl/intl.dart';

DateTime convertToDateTime(String date, String time) {
  DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  return formatter.parse("$date $time:00.00");
}
