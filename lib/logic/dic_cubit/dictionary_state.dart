part of 'dictionary_cubit.dart';

abstract class WordState extends Equatable {
  const WordState();
  @override
  List<Object> get props => [];
}

class WordInitial extends WordState {}

class WordLoading extends WordState {}

class SearchNotFound extends WordState {
  final WordNotFound word;
  const SearchNotFound({required this.word});

  @override
  List<Object> get props => [word];
}

class WordFound extends WordState {
  final List<DictionaryModel> dictionary;
  const WordFound({required this.dictionary});

  @override
  List<Object> get props => [dictionary];
}

class WordError extends WordState {
  final String message;
  const WordError({required this.message});

  @override
  List<Object> get props => [message];
}
