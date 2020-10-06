import 'package:intl/intl.dart';

class TimeFormat {

  static final DateFormat standardFormatter = DateFormat.yMd().add_jm();

  static String fromEpoch(int epochInSeconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epochInSeconds * 1000);
    return standardFormatter.format(dateTime);
  }

}