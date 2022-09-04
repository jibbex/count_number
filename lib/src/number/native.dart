import 'package:count_number/src/number_impl.dart';

class Number implements NumberImpl {
  @override
  bool isInteger(num? val) => val is int;
}