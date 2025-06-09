import 'package:flutter/material.dart';

class LiveCounterScreen extends StatelessWidget {
  final String exerciseId;

  const LiveCounterScreen({
    super.key,
    required this.exerciseId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Live Counter Screen - Exercise: $exerciseId')),
    );
  }
}
