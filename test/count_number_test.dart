/**
 * Copyright 2022 Manfred Michaelis <mm@michm.de>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:count_number/count_number.dart';

void main() {
  /// Tests counting up with an integer value
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

  /// Tests counting down with an integer value
  test('counts an value down', () {
    int current = 0;
    int startValue = 150;
    int endValue = -50;

    CountNumber(
      endValue: endValue,
      startValue: startValue,
      onUpdate: (value) {
        current = value.toInt();
        if (kDebugMode) print(value);
      },
      onDone: () => expect(current, endValue),
    ).start();
  });

  /// Tests counting up with an double value
  test('counts a double value up', () {
    double current = 0;
    double endValue = 199.75;

    CountNumber(
      endValue: endValue,
      onUpdate: (value) {
        current = value.toDouble();
        if (kDebugMode) print(value);
      },
      onDone: () => expect(current, endValue),
    ).start();
  });

  /// Tests counting down with an double value
  test('counts a double value down', () {
    double current = 0;
    double startValue = 149.778;
    double endValue = -75.275;

    CountNumber(
      endValue: endValue,
      startValue: startValue,
      onUpdate: (value) {
        current = value.toDouble();
        if (kDebugMode) print(value);
      },
      onDone: () => expect(current, endValue),
    ).start();
  });

  /// Tests dynamic counting
  test('counts integer and double values up and down', () {
    int iteration = 0;
    num current = 0;
    num startValue = 0;
    num endValue = 500;

    CountNumber(
      endValue: endValue,
      startValue: startValue, 
      isDynamic: true,
      onUpdate: (value) {
        if (value is int) {
          current = value.toInt();
        } else {
          current = value.toDouble();
        }
        
        if (kDebugMode) print(value);
      },
      onDone: () {
        if (iteration == 0) {
          expect(current, 500);
        }
        
        switch (iteration) {
          case 0: 
            expect(current, 500);
            endValue = 25.75;
            break;
          case 1: 
            expect(current, 25.75);
            endValue = -15;
            break;
          case 2: 
            expect(current, -15);
            endValue = 15782.75899;
            break;
          case 3:
            expect(current, 15782.75899);
            break;
        }
        
        iteration++;
      },
    ).start();
  });
}
