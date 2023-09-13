import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaf/src/insurance/customer.dart';

/// Displays detailed information about a SampleItem.
class CustomerDetailsView extends StatelessWidget {
  const CustomerDetailsView({super.key, required this.customerData});

  static const routeName = '/sample_item';
  final Customer customerData;

  @override
  Widget build(BuildContext context) {
    NumberFormat f = NumberFormat.compact();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customerData.name,
            style: const TextStyle(fontSize: 75),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '\$${f.format(customerData.salary)}',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                '@${customerData.percentage}%',
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
          Text(
            '=  \$ ${f.format(customerData.salary * double.parse(customerData.percentage) / 100)}',
            style: const TextStyle(fontSize: 50),
          ),
        ],
      ),
    );
  }
}
