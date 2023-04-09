import 'package:bloc/bloc.dart';
import 'package:bloc_ex1/bloc/fetchResult.dart';
import 'package:bloc_ex1/bloc/loadAction.dart';
import 'package:bloc_ex1/main.dart';
import 'package:bloc_ex1/modal/person.dart';

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  //initial state is null
  PersonsBloc() : super(null) {
    on<LoadPersonAction>(
      (event, emit) async {
        final url = event.url;
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
          final person = await getPersons(url.urlString);
          _cache[url] = person;
          final result =
              FetchResult(persons: person, isRetrievedFromCache: false);
          emit(result);
        }
      },
    );
  }
}
