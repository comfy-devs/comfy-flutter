String secondsToString(int time) {
    if(time < 0) { return "??"; }
	String timeString = '';

    final hrs = (time / 3600).floor();
    time %= 3600;
    final mins = (time / 60).floor();
    final secs = time % 60;

    if (hrs >= 1) timeString += '$hrs:';
    timeString += '${mins >= 10 ? mins : (hrs >= 1 ? "0" : "") + mins.toString()}:';
    timeString += '${secs >= 10 ? secs : "0${secs.toString()}"}';
    return timeString;
}
String secondsToStringHuman(int time) {
    if(time < 0) { return "??"; }
	String timeString = '';

    final years = (time / 31557600).floor();
    time %= 31557600;
    final months = (time / 2629800).floor();
    time %= 2629800;
    final days = (time / 86400).floor();
    time %= 86400;
    final hrs = (time / 3600).floor();
    time %= 3600;
    final mins = (time / 60).floor();
    final secs = time % 60;

    timeString += years > 0 ? '${years}y ' : "";
    timeString += months > 0 ? '${months}mo ' : "";
    timeString += days > 0 ? '${days}d ' : "";
    timeString += hrs > 0 ? '${hrs}h ' : "";
    timeString += mins > 0 ? '${mins}m ' : "";
    timeString += secs > 0 ? '${secs}s ' : "";
    timeString = timeString.substring(0, timeString.length - 1);
    return timeString;
}