import 'package:bloc_ex1/main.dart';
import 'package:bloc_ex1/modal/person.dart';
import 'package:flutter/cupertino.dart';

const person1url =
    'https://raw.githubusercontent.com/Snehilg/Snehilg.github.io/main/person1.json';
const person2url =
    'https://raw.githubusercontent.com/Snehilg/Snehilg.github.io/main/person2.json';
//defining loader for fetching the data based on string url
typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({required this.url, required this.loader}) : super();
}

/*//defining enum for holding persons1 & persons2
enum PersonUrl { persons1, persons2 }

//extension on enum for getting url, getter function
extension UrlString on PersonUrl {
  String get urlString {
    //this here refers to instance of enum PersonUrl
    switch (this) {
      case PersonUrl.persons1:
        return "https://raw.githubusercontent.com/Snehilg/Snehilg.github.io/main/person1.json";
      //"https://jsonkeeper.com/b/Z61V"
      case PersonUrl.persons2:
        return "https://raw.githubusercontent.com/Snehilg/Snehilg.github.io/main/person2.json";
      //"https://jsonkeeper.com/b/UFF0"
    }
  }
}*/
