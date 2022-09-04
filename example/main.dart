import 'package:count_number/count_number.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CountApp());
}

class CountApp extends StatelessWidget {
  const CountApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Count Numbers',
      home: const Home('Count Numbers'),
      theme: Theme.of(context).copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      color: Colors.lightGreen,
    );
  }
}

class Home extends StatefulWidget {
  final String title;

  const Home(this.title, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  num _number = 0;
  bool _isNumActive = true;
  late CountNumber _countNumber;
  late TextEditingController _txtController;

  void _onPressed() {
    if (_isNumActive) {
      num? newVal = num.tryParse(_txtController.text);
      if (newVal != null) {
        _isNumActive = false;
        _countNumber.value = newVal;
      }
    }
  }

  void onCountUpdate(num value) {
    setState(() => _number = value);
  }

  void onCountDone() {
    setState(() => _isNumActive = true);
  }

  @override
  void initState() {
    _txtController = TextEditingController(text: '0');
    _countNumber = CountNumber(
      endValue: _number,
      onUpdate: onCountUpdate,
      onDone: onCountDone,
      isDynamic: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _countNumber.stop();
    _txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
                child: Text(
                  CountNumber.isInteger(_number)
                      ? _number.toString()
                      : _number.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headline1,
                ),
              )),
          Card(
            elevation: 12,
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: TextField(
                      controller: _txtController,
                      enabled: _isNumActive,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onSubmitted: (_) => _onPressed(),
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.w200,
                      ),
                      decoration: const InputDecoration(
                        fillColor: Colors.white70,
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.cyan,
                            )),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _onPressed,
                  child: const Text('Count!'),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}