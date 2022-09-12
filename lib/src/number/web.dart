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
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' show context;

import 'package:count_number/src/number_impl.dart';

/// Web implementation of NumberImpl
class Number implements NumberImpl {
  /// Returns true if passed value has type int. Otherwise it will
  /// return false. Calls Number.isInteger from javascript context.
  @override
  bool isInteger(num? val) => context['Number'].callMethod('isInteger', [val]);
}
