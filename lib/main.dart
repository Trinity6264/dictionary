// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dictionary/presentation/screens/word_description.dart';
import 'package:dictionary/presentation/screens/word_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dictionary/logic/dic_cubit/dictionary_cubit.dart';
import 'package:dictionary/repository/dictioanry_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    dictionary: DictionaryRepo(),
  ));
}

class MyApp extends StatelessWidget {
  final DictionaryRepo dictionary;
  const MyApp({
    Key? key,
    required this.dictionary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DictionaryCubit>(
      create: (context) => DictionaryCubit(dictionaryRepo: dictionary),
      child: MaterialApp(
        title: 'Flutter Dictionary',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // scaffoldBackgroundColor: Color.
        ),
        home: const WordSearch(),
      ),
    );
  }
}
