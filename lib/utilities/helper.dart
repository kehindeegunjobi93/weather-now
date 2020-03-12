import 'package:intl/intl.dart';

class Helper {
  static String getFormattedDate(DateTime dateTime){
    return new DateFormat("EEE, MMM d, y").format(dateTime);
  }
}