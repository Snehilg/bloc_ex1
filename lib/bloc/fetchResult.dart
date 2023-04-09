import 'package:flutter/cupertino.dart';

import '../modal/person.dart';

@immutable
class FetchResult {
  //we are using iterable coz each json will have list of persons
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult(
      {required this.persons, required this.isRetrievedFromCache});

  //to get string of the class data
  @override
  String toString() =>
      "FetchResult (isRetrievedFromCache = $isRetrievedFromCache, persons =$persons)";
}
