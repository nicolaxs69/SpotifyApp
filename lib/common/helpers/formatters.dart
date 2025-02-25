import 'dart:core';

extension DurationFormatter on String {
  String formatDuration() {
    final parts = this.split('.');
    final minutes = parts[0];
    var seconds = '00';

    if (parts.length > 1) {
      final decimalSeconds = int.parse(parts[1]);
      seconds = '${decimalSeconds * 60}';
    }

    return '$minutes:$seconds';
  }
}
