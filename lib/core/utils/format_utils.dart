import 'package:intl/intl.dart';

class FormatUtils{
  static String formatToYYYYMMDD(DateTime dateTime) {
    return DateFormat('yyyy.MM.dd').format(dateTime);
  }
}