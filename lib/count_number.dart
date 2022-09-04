library count_number;

import 'dart:async';
import 'package:flutter/physics.dart';
import './src/number/number.dart';

/// Counts up or down a value based on a spring
/// animation. The value can be an integer
/// or a double.
class CountNumber {
  num _endValue;
  num _value = 0;
  Timer? _timer;

  /// The value at the end of the count.
  final num endValue;

  /// The value at the start of the count.
  final num? startValue;

  /// Speed of the count.
  final double? velocity;

  /// Description of the SpringSimulation.
  final SpringDescription? springDescription;

  /// Re-animating the counting process
  /// when setting the value property.
  final bool isDynamic;

  /// The callback is called when the
  /// value has changed.
  final void Function(num) onUpdate;

  /// The callback is called at the
  /// end of the SpringSimulation.
  final void Function()? onDone;

  CountNumber({
    this.onDone,
    this.velocity,
    this.startValue,
    this.isDynamic = false,
    this.springDescription,
    required this.endValue,
    required this.onUpdate,
  }) : _endValue = endValue;

  /// Starts an internal periodic timer that
  /// checks the state of the simulation at
  /// each tick and calls one of the
  /// callbacks if necessary.
  void start() {
    stop();

    var sim = SpringSimulation(
      springDescription ??
          const SpringDescription(
            mass: 16,
            stiffness: 2,
            damping: 0.7,
          ),
      _convToDouble(_value),
      _convToDouble(_endValue),
      velocity ?? 2,
    );

    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      double tick = _timer!.tick / 100;
      num value = isInteger(_endValue) ? sim.x(tick).round() : sim.x(tick);

      if (_value != value) {
        _value = value;
        onUpdate(_value);
      }

      if (sim.isDone(tick) || _value == _endValue) {
        _timer!.cancel();
        if (onDone != null) onDone!();
      }
    });
  }

  /// Ends the counting process.
  void stop() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  /// Gets the actual value.
  num get value => _value;

  /// If isDynamic is set to 'true',
  /// it counts from the old to the new value.
  set value(num value) {
    assert(isDynamic, "CountNumber wasn't initialized with 'isDynamic = true'");

    if (isDynamic) {
      _endValue = value;
      start();
    }
  }

  /// Converts null and int to double
  /// and returns the value.
  static double _convToDouble(num? val) {
    if (val == null) {
      return 0;
    } else if (val is int) {
      return val.toDouble();
    }

    if (val is! double) {
      throw ArgumentError('Value is neither int nor double');
    }

    return val;
  }

  /// Checks that the number passed is an
  /// integer in a platform-reliable way.
  static bool isInteger(num? val) => Number().isInteger(val);
}
