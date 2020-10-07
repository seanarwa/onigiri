import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeFormat {
  static final DateFormat standardFormatter = DateFormat.yMd().add_jm();

  static String fromEpoch(int epochInMilliseconds) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(epochInMilliseconds);
    return standardFormatter.format(dateTime);
  }

  static String fromTimestamp(Timestamp timestamp) {
    return fromEpoch(timestamp.millisecondsSinceEpoch);
  }
}
