import 'package:intl/intl.dart';

void log(dynamic data) {
  // if (kDebugMode)
    print("[${DateFormat('HH:mm:ss:SSS').format(DateTime.now().toUtc())}] - ${data.toString()}");
 }
