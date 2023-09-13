// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Customer',
      json,
      ($checkedConvert) {
        final val = Customer(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          salary: $checkedConvert('salary', (v) => v as int),
          percentage: $checkedConvert('percentage', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'salary': instance.salary,
      'percentage': instance.percentage,
    };
