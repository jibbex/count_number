// ignore: avoid_web_libraries_in_flutter
import 'dart:js' show context;

import 'package:count_number/src/number_impl.dart';

class Number implements NumberImpl {
  @override
  bool isInteger(num? val) =>
      context['Number'].callMethod('isInteger', [val]);
}
