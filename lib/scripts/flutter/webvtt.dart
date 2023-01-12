String parseSubtitles(String source) {
  List<String> lines = source.split('\n').sublist(2);
  List<String> out = ['WEBVTT', ''];

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].isEmpty || lines[i].contains(' --> ')) {
      out.add(lines[i]);
    } else {
      if (out.last.contains(' --> ')) {
        out.add(lines[i]);
      } else {
        out[out.length - 1] += '/COMFY_N/' + lines[i];
      }
    }
  }

  String result = out.join('\n');
  result = result.replaceAll('<i>', '/COMFY_I/').replaceAll('</i>', '');
  result = result.replaceAll('<b>', '/COMFY_B/').replaceAll('</b>', '');
  result = result.replaceAll('<u>', '/COMFY_U/').replaceAll('</u>', '');

  return result;
}
