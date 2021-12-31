extension DateTimeExtenion on DateTime {
  int get timestamp => millisecondsSinceEpoch + 420 * 60 * 1000;

//  gmt +7 offset 420min

  String get shortFormat => '$formattedHour:$formattedMinute $formattedDay/$month/$year';

  String get shortFormatDate => '$formattedDay/$formattedMonth/$year';

  String get formattedMinute => minute < 10 ? '0$minute' : minute.toString();

  String get formattedHour => hour < 10 ? '0$hour' : hour.toString();

  String get formattedDay => day < 10 ? '0$day' : day.toString();

  String get formattedMonth => month < 10 ? '0$month' : month.toString();
}
