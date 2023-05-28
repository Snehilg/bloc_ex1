import 'package:bloc_ex1/bloc/personsBloc.dart';
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

  //overriding equality operator for this class
  @override
  bool operator ==(covariant FetchResult other) =>
      (persons.isEqualToIgnoringOrdering(other.persons)) &&
      (isRetrievedFromCache == other.isRetrievedFromCache);

  //we also have to override the hashcode as we are overriding the == operator
  @override
  int get hashcode => Object.hash(persons, isRetrievedFromCache);
}
