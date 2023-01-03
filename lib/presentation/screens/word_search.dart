import 'package:dictionary/constant/custom_color.dart';
import 'package:dictionary/logic/dic_cubit/dictionary_cubit.dart';
import 'package:dictionary/presentation/screens/word_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordSearch extends StatefulWidget {
  const WordSearch({super.key});

  @override
  State<WordSearch> createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: CustomColor.darkGrey,
        title: const Text(
          'Flutter Dictionary',
          style: TextStyle(
            color: CustomColor.textLightGrey,
          ),
        ),
      ),
      backgroundColor: CustomColor.darkGrey,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              style: const TextStyle(
                color: CustomColor.textLightGrey,
              ),
              onSubmitted: (value) {
                if (controller.text.isEmpty) return;
                BlocProvider.of<DictionaryCubit>(context, listen: false)
                    .getData(controller.text);
              },
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColor.textLightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColor.textLightGrey),
                ),
                hintText: 'Enter a word',
                hintStyle: TextStyle(
                  color: CustomColor.textLightGrey,
                ),
              ),
            ),
            const SizedBox(height: 50),
            BlocBuilder<DictionaryCubit, WordState>(
              builder: (context, state) {
                if (state is WordLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WordError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        color: CustomColor.textLightGrey,
                      ),
                    ),
                  );
                } else if (state is SearchNotFound) {
                  return Center(
                    child: Text(
                      state.word.title!,
                      style: const TextStyle(
                        color: CustomColor.textLightGrey,
                      ),
                    ),
                  );
                } else if (state is WordFound) {
                  return wordFound(state);
                }
                return const Center(
                  child: Text(
                    'Search for a word 👍',
                    style: TextStyle(
                      color: CustomColor.textLightGrey,
                      fontSize: 20.0,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column wordFound(WordFound state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${state.dictionary[0].word}',
          style: const TextStyle(
            color: CustomColor.lineColor,
            fontSize: 50.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(color: CustomColor.textLightGrey),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .55,
          child: ListView.separated(
            // shrinkWrap: true,
            separatorBuilder: (context, index) =>
                const Divider(color: CustomColor.lineColor),
            itemCount: state.dictionary.length,
            itemBuilder: ((context, index) {
              final model = state.dictionary[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => WordDescription(model: model),
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height * .06,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      model.word!,
                      style: const TextStyle(
                        color: CustomColor.textLightGrey,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
