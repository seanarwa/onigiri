import 'package:intl/intl.dart';

class TimeFormat {
  static final DateFormat standardFormatter = DateFormat.yMd().add_jm();

  static String fromEpoch(int epochInMilliseconds) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochInMilliseconds);
    return standardFormatter.format(dateTime);
  }
}
