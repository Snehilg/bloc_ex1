import 'package:bloc_ex1/bloc/fetchResult.dart';
import 'package:bloc_ex1/bloc/loadAction.dart';
import 'package:bloc_ex1/bloc/personsBloc.dart';
import 'package:bloc_ex1/modal/person.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

//functions and mocked data for testing
//the whole moto of test isto test maximum lines and logic of
//PersonsBloc write test for every possible cases
const mockedPersons1 = [
  Person("Foo 1", 20),
  Person("Bar 1", 30),
  Person("Baz 1", 40),
];

const mockedPersons2 = [
  Person("Foo 2", 60),
  Person("Bar 2", 70),
  Person("Baz 2", 80),
];

Future<Iterable<Person>> getMockedPerson1(String url) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> getMockedPersons2(String url) =>
    Future.value(mockedPersons2);

//bloc will be closed after every test and setUp() will be called
//create group coz we find that these test relate with each other
void main() {
  group('Testing Bloc', () {
    //it will be initialised before anything(with setUp() only once in the group) as
    //each test scenario will require an instance
    //test scenario like initialStateTest, Person1 load test, 2 times Person load test
    //in which 1 person will already be available in the cache
    late PersonsBloc bloc;
    setUp(() {
      bloc = PersonsBloc();
    });

    //test for initial state
    //build must return an instance of bloc
    //verify will take bloc and return boolean after verifying state
    blocTest<PersonsBloc, FetchResult?>('initial state test',
        build: () => bloc, verify: (bloc) => bloc.state == null);

    //fetch mock data Person1 and compare fetch result
    blocTest<PersonsBloc, FetchResult?>(
      'testing person1 load state',
      build: () => bloc,
      act: (bloc) {
        //event for mockperson1
        bloc.add(const LoadPersonsAction(
          url: 'dummy_url_1',
          loader: getMockedPerson1,
        ));
        //event for mockperson1
        bloc.add(const LoadPersonsAction(
          url: 'dummy_url_1',
          loader: getMockedPerson1,
        ));
      }, //act
      //array of result to be expected
      expect: () => [
        const FetchResult(persons: mockedPersons1, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons1, isRetrievedFromCache: true),
      ], //expect
    ); //blocTest

    //fetch mock data Person2 and compare fetch result
    blocTest<PersonsBloc, FetchResult?>(
      'testing person1 load state',
      build: () => bloc,
      act: (bloc) {
        //event for mockperson2
        bloc.add(const LoadPersonsAction(
          url: 'dummy_url_2',
          loader: getMockedPersons2,
        ));
        //event for mockperson2
        bloc.add(const LoadPersonsAction(
          url: 'dummy_url_2',
          loader: getMockedPersons2,
        ));
      }, //act
      //array of result to be expected
      expect: () => [
        const FetchResult(persons: mockedPersons2, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons2, isRetrievedFromCache: true),
      ], //expect
    ); //bloc test
  }); //group
}
