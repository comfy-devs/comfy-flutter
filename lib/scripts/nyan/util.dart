String secondsToString(int time) {
  if (time < 0) {
    return "??";
  }
  String timeString = '';

  final hrs = (time / 3600).floor();
  time %= 3600;
  final mins = (time / 60).floor();
  final secs = time % 60;

  if (hrs >= 1) timeString += '$hrs:';
  timeString +=
      '${mins >= 10 ? mins : (hrs >= 1 ? "0" : "") + mins.toString()}:';
  timeString += '${secs >= 10 ? secs : "0${secs.toString()}"}';
  return timeString;
}

String secondsToStringHuman(int time, int limit) {
  List<String> units = ["y", "mo", "d", "h", "m", "s"];
  List<int> values = [
    (time / 31536000).floor(),
    ((time / 2592000) % 12).floor(),
    ((time / 86400) % 30).floor(),
    ((time / 3600) % 24).floor(),
    ((time / 60) % 60).floor(),
    ((time) % 60).floor(),
  ];

  String result = "";
  for (int i = 0; i < limit; i++) {
    if (values[i] != 0) {
      result += '${values[i]}${units[i]} ';
    }
  }

  return result.trim();
}
