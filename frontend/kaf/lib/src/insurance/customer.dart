import 'dart:convert';

/// A placeholder class that represents an entity or model.
class Customer {
  final int id;
  final String name;
  final int salary;
  final double percentage;

  const Customer({
    required this.id,
    required this.name,
    required this.salary,
    required this.percentage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'salary': salary,
      'percentage': percentage,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      salary: map['salary'],
      percentage: map['percentage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);
}
