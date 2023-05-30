import 'package:bloc/bloc.dart';
import 'package:bloc_ex1/bloc/fetchResult.dart';
import 'package:bloc_ex1/bloc/loadAction.dart';
import 'package:bloc_ex1/modal/person.dart';

//to compare persons for testing pov
extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  //this is a method, not constructor
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  //initial state is null
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        //the practice of keeping variables as final beforehand , not using event.blabla everytime
        final url = event.url;
        final loader = event.loader;
        if (_cache.containsKey(url)) {
          //cache has the data
          final cachedPersons = _cache[url]!;
          //initialising new result object
          final result =
              FetchResult(persons: cachedPersons, isRetrievedFromCache: true);
          emit(result); //emitting
        } else {
          //if data isn't in the cache
          //fetch data from the getPersons -> save it in cache -> use cache to create object -> emit
          //await coz it's returning Future
          final person = await loader(url);
          _cache[url] = person;
          final result =
              FetchResult(persons: person, isRetrievedFromCache: false);
          emit(result);
        }
      },
    );
  }
}
