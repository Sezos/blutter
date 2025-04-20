import 'package:intl/intl.dart';

String formatMoney(dynamic value) {
  if (value == null) {
    return "0₮";
  }
  if (value is double) {
    return "${NumberFormat(",###.##", "mn-MN").format(value.floor())}₮";
  }
  if (value is int || value is num) {
    return "${NumberFormat(",###.##", "mn-MN").format(value.toDouble())}₮";
  }

  if (value is String) {
    if (double.tryParse(value) == null) {
      throw "Value is not number String";
    }
    return "${NumberFormat(",###.##", "mn-MN").format(double.parse(value))}₮";
  }
  throw "Unexpected Type";
}

String formatDouble(double value) {
  return NumberFormat(",###.##", "mn-MN").format(value);
}
