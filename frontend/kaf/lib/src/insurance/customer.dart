import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'customer.g.dart';

/// A placeholder class that represents an entity or model.
@JsonSerializable()
class Customer extends Equatable {
  final int id;
  final String name;
  final int salary;
  // TODO: fix this hack
  final String percentage;

  const Customer({
    required this.id,
    required this.name,
    required this.salary,
    required this.percentage,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  List<Object> get props => [id, name];
}
