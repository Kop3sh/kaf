import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'John Doe',
            style: TextStyle(fontSize: 75),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '\$50k',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '@ 50%',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Text(
            '=  \$25k',
            style: TextStyle(fontSize: 50),
          ),
        ],
      ),
    );
  }
}
