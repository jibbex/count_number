import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:count_number/count_number.dart';

void main() {
  test('counts an value up', () {
    int current = 0;
    int endValue = 200;

    CountNumber(
      endValue: endValue,
      onUpdate: (value) {
        current = value.toInt();
        if (kDebugMode) print(value);
      },
      onDone: () => expect(current, endValue),
    ).start();
  });
}
