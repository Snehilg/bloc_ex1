import 'dart:convert';
import 'dart:io';

import 'package:bloc_ex1/bloc/fetchResult.dart';
import 'package:bloc_ex1/bloc/loadAction.dart';
import 'package:bloc_ex1/bloc/personsBloc.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modal/person.dart';

void main() {
  runApp(
    MaterialApp(
      title: "json flutter app",
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        //injecting bloc , material app wont be constant anymore
        create: (_) => PersonsBloc(),
        child: const HomePage(),
      ),
    ),
  );
}

/*const Iterable<String> names = ["foo", "bar"];
void testIt() {
  final baz = names[2];
  //error we get {The operator '[]' isn't defined for the type 'Iterable<String>'}
}
*/
//extension on iterable to make it more reliable
//list[no._dosen't_exist] kuch hona chahiye tab
//enable extension to avoid above error
extension Subscript<T> on Iterable<T> {
  operator [](int index) => length > index ? elementAt(index) : null;
}

//defining enum for holding persons1 & persons2
enum PersonUrl { persons1, persons2 }

//extension on enum for getting url, getter function
extension UrlString on PersonUrl {
  String get urlString {
    //this here refers to instance of enum PersonUrl
    switch (this) {
      case PersonUrl.persons1:
        return "https://jsonkeeper.com/b/Z61V";
      case PersonUrl.persons2:
        return "https://jsonkeeper.com/b/UFF0";
    }
  }
}

//function for downloading and parsing JSON to person object //long code
//study this well
//this function is repository
Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url)) //using http to get req object from url
    .then((req) => req.close()) //closing request to get response
    .then((resp) =>
        resp.transform(utf8.decoder).join()) //transforming resp to string
    .then((str) => jsonDecode(str) as List<dynamic>) //string to list<dynamic>
    .then((list) => list.map((e) => Person.fromJSON(
        e))); //each list(will have many person data) value is used for a Person object

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Bloc myBloc;
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: const Text("Json App"),
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    //accessing bloc through context.read()
                    context.read<PersonsBloc>().add(
                          const LoadPersonsAction(
                            url: PersonUrl.persons1,
                          ),
                        );
                  },
                  child: const Text("Load JSON1"),
                ),
                TextButton(
                  onPressed: () {
                    //accessing bloc through context.read()
                    context.read<PersonsBloc>().add(
                          const LoadPersonsAction(
                            url: PersonUrl.persons2,
                          ),
                        );
                  },
                  child: const Text("Load JSON2"),
                ),
              ],
            ),
            BlocBuilder<PersonsBloc, FetchResult?>(
                buildWhen: (previouResult, currentResult) {
              //if previous had different Iterable of persons than current
              return (previouResult?.persons != currentResult?.persons);
            }, builder: (context, fetchResult) {
              final persons = fetchResult?.persons;
              if (persons == null) {
                //if result is null
                return const SizedBox();
              } else {
                return Expanded(
                  //using expanded to adjust list view
                  child: ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        final person = persons[index]!;
                        return ListTile(
                          title: Text(person.name),
                        );
                      }),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
