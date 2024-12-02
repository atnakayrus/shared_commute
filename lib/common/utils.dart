String formattedTime(DateTime time) {
  return "${time.hour ~/ 10}${time.hour % 10} : ${time.minute ~/ 10}${time.minute % 10}";
}
