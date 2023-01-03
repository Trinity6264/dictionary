// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dictionary/constant/custom_color.dart';
import 'package:dictionary/constant/enums.dart';
import 'package:dictionary/logic/sound/sound_cubit.dart';
import 'package:dictionary/model/dictionary/dictionary_model.dart';
import 'package:dictionary/presentation/widget/title_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordDescription extends StatefulWidget {
  final DictionaryModel model;
  const WordDescription({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<WordDescription> createState() => _WordDescriptionState();
}

class _WordDescriptionState extends State<WordDescription> {
  @override
  void initState() {
    if (widget.model.phonetics!.isEmpty) return;
    context
        .read<SoundCubit>()
        .loadSound(url: widget.model.phonetics![0].audio!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.darkGrey,
      appBar: AppBar(
        title: Text(widget.model.word ?? ''),
        backgroundColor: CustomColor.darkGrey,
      ),
      body: BlocListener<SoundCubit, SoundState>(
        listener: (context, state) {
          if (state is SoundPlayingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * .07,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: CustomColor.lineColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up,
                          color: CustomColor.textLightGrey),
                      const SizedBox(width: 10),
                      Text(widget.model.word!),
                      const Spacer(),
                      IconButton(
                        onPressed: () => context.read<SoundCubit>().playAudio,
                        icon: const Icon(Icons.play_arrow_sharp),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star, color: CustomColor.textLightGrey),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                head('Pronunciation'),
                const SizedBox(height: 10),
                TitleBody(
                  title: 'IPA:   ',
                  body: widget.model.phonetics!.isEmpty
                      ? 'none'
                      : widget.model.phonetics?[0].text ?? '',
                ),
                const SizedBox(height: 5),
                const Divider(color: CustomColor.lineColor),
                const SizedBox(height: 5),
                head('Meaning'),
                const SizedBox(height: 5),
                TitleBody(
                  title: 'Part Of Speech:   ',
                  body: widget.model.meanings?[0].partOfSpeech ?? '',
                ),
                const SizedBox(height: 5),
                head('Definition:'),
                const SizedBox(height: 5),
                Column(
                  children: widget.model.meanings != null
                      ? widget.model.meanings!
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: e.definitions != null
                                  ? e.definitions!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '🗣️ ${e.definition}',
                                              style: const TextStyle(
                                                color:
                                                    CustomColor.textLightGrey,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ))
                                      .toList()
                                  : [],
                            ),
                          )
                          .toList()
                      : [],
                ),
                const Divider(color: CustomColor.lineColor),
                const SizedBox(height: 5),
                head('Synonyms:'),
                const SizedBox(height: 5),
                Column(
                  children: widget.model.meanings != null
                      ? widget.model.meanings!
                          .map(
                            (e) => Column(
                              children: e.synonyms != null
                                  ? e.synonyms!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color:
                                                    CustomColor.textLightGrey,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ))
                                      .toList()
                                  : [],
                            ),
                          )
                          .toList()
                      : [],
                ),
                const Divider(color: CustomColor.lineColor),
                const SizedBox(height: 5),
                head('Antonyms:'),
                const SizedBox(height: 5),
                Column(
                  children: widget.model.meanings != null
                      ? widget.model.meanings!
                          .map(
                            (e) => Column(
                              children: e.antonyms != null
                                  ? e.antonyms!
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                color:
                                                    CustomColor.textLightGrey,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ))
                                      .toList()
                                  : [],
                            ),
                          )
                          .toList()
                      : [],
                ),
                const Divider(color: CustomColor.lineColor),
                const SizedBox(height: 5),
                head('Licenses:'),
                const SizedBox(height: 5),
                TitleBody(
                  title: 'Name:   ',
                  body: widget.model.license?.name ?? '',
                ),
                const Divider(color: CustomColor.lineColor),
                const SizedBox(height: 5),
                head('Source:'),
                const SizedBox(height: 5),
                TitleBody(
                  title: 'Url:   ',
                  body: widget.model.sourceUrls?[0] ?? '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text head(String val) {
    return Text(
      val,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: CustomColor.textLightGrey,
      ),
    );
  }
}
