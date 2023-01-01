import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dictionary/model/dictionary_model.dart';
import 'package:dictionary/model/not_found.dart';
import 'package:dictionary/repository/dictioanry_repo.dart';
import 'package:equatable/equatable.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<WordState> {
  final DictionaryRepo dictionaryRepo;
  DictionaryCubit({required this.dictionaryRepo}) : super(WordInitial());

  void getData(String val) async {
    emit(WordLoading());
    try {
      final res = await dictionaryRepo.getData(val);
      if (res != null && res is List<DictionaryModel>) {
        emit(WordFound(dictionary: res));
      } else {
        emit(SearchNotFound(word: res));
      }
      // emit(WordFound(dictionary: res));

    } on SocketException catch (e) {
      emit(const WordError(
          message: 'Connection error,check your internet connection '));
    } on TimeoutException catch (e) {
      emit(const WordError(message: 'Timeout,check your internet connection '));
    } on Exception catch (e) {
      log(e.toString());
      //  emit( NoWordFound());
    } catch (e) {
      log(e.runtimeType.toString());
      emit(const WordError(message: 'Error happend, Sorry try again 🥳'));
    }
  }
}
