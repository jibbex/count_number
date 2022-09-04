# Flutter package: count_number

Animates the counting process of a value based on a spring simulation. 
Starts an internal periodic timer that checks the state of the simulation 
at each tick and calls one of the callbacks if necessary. The value can 
be an integer or a double.

<img title="example" src="https://raw.githubusercontent.com/jibbex/count_number/main/assets/count_num.gif" alt="" width="255" data-align="center">

## Features

* Counts animated a number up or down
* Supports integer and double values
* Calls the callbacks only when actually necessary
* Can be initialized as dynamic
  * Setting the property value triggers a new counting process

## Getting started

Add the dependency:

```bash
flutter pub add count_number
```

Import the package:

```bash
import 'package:count_number/count_number.dart';
```

## Usage

Initialize a CountNumber object:

```dart
class _HomeState extends State<Home> {
  int _number = 0;
  late CountNumber _countNumber;

  @override
  void initState() {
    _countNumber = CountNumber(
      endValue: 50,
      onUpdate: (value) => setState(() => _number = value as int),
    );
    super.initState();
  }

  @override
  void dispose() {
    _countNumber.stop();
    super.dispose();
  }
}
```

Run the `start()` method:

```dart
 @override
  Widget build(BuildContext context) {
    _countNumber.start();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Expanded(
        child: Center(
            child: Text(
            _number.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ),
    );
  }
```
