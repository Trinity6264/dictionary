// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dictionary/constant/enums.dart';
import 'package:dictionary/logic/internet/internet_cubit.dart';
import 'package:dictionary/logic/sound/sound_cubit.dart';
import 'package:dictionary/presentation/screens/word_description.dart';
import 'package:dictionary/presentation/screens/word_search.dart';
import 'package:dictionary/presentation/widget/all_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dictionary/logic/dic_cubit/dictionary_cubit.dart';
import 'package:dictionary/repository/dictioanry_repo.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    dictionary: DictionaryRepo(),
    connectivity: Connectivity(),
    player: AudioPlayer(),
  ));
}

class MyApp extends StatelessWidget {
  final DictionaryRepo dictionary;
  final Connectivity connectivity;
  final AudioPlayer player;
  const MyApp({
    Key? key,
    required this.dictionary,
    required this.connectivity,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DictionaryCubit>(
          create: (context) => DictionaryCubit(dictionaryRepo: dictionary),
        ),
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => SoundCubit(player: player),
        ),
      ],
      child: MaterialApp(
        title: 'Dictionary',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected &&
                state.connectionType == ConnectionType.mobile) {
              AllWidgets().snackBar(context);
            } else if (state is InternetConnected &&
                state.connectionType == ConnectionType.wifi) {
              AllWidgets().snackBar(context);
            } else if (state is InternetDisConnected) {
              AllWidgets().banner(context);
            }
          },
          child: const WordSearch(),
        ),
      ),
    );
  }
}
