import 'package:flutter/material.dart';
import 'package:native_example/shared_method_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String data = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> getValue() async {
    data = await SharedMethodChannel.getSharedValue('key') ?? '';
    setState(() {});
  }

  Future<void> setValue() async => await SharedMethodChannel.setSharedValue(
      'key', 'This is shared example2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(data),
              ElevatedButton(
                  onPressed: () async {
                    if (mounted) {
                      await setValue();
                      await getValue();
                    }
                  },
                  child: const Text('Share Value')),
            ],
          ),
        ),
      ),
    );
  }
}
