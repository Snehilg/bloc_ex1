import 'package:bloc_ex1/main.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final PersonUrl url;
  const LoadPersonsAction({required this.url}) : super();
}
