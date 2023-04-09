import 'package:flutter/cupertino.dart';

@immutable
class Person {
  final String name;
  final int age;
  //fromJSON is a named constructor & : is used in place of {}
  Person.fromJSON(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}
