import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'license.dart';
import 'meaning.dart';
import 'phonetic.dart';

List<DictionaryModel> wordFoundFromMap(String str) =>
    List<DictionaryModel>.from(
        json.decode(str).map((x) => DictionaryModel.fromMap(x)));

class DictionaryModel extends Equatable {
  final String? word;
  final List<Phonetic>? phonetics;
  final List<Meaning>? meanings;
  final License? license;
  final List<dynamic>? sourceUrls;

  const DictionaryModel({
    this.word,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  factory DictionaryModel.fromMap(Map<String, dynamic> data) => DictionaryModel(
        word: data['word'] as String?,
        phonetics: (data['phonetics'] as List<dynamic>?)
            ?.map((e) => Phonetic.fromMap(e as Map<String, dynamic>))
            .toList(),
        meanings: (data['meanings'] as List<dynamic>?)
            ?.map((e) => Meaning.fromMap(e as Map<String, dynamic>))
            .toList(),
        license: data['license'] == null
            ? null
            : License.fromMap(data['license'] as Map<String, dynamic>),
        sourceUrls: data['sourceUrls'],
      );

  Map<String, dynamic> toMap() => {
        'word': word,
        'phonetics': phonetics?.map((e) => e.toMap()).toList(),
        'meanings': meanings?.map((e) => e.toMap()).toList(),
        'license': license?.toMap(),
        'sourceUrls': sourceUrls,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DictionaryModel].
  factory DictionaryModel.fromJson(String data) {
    return DictionaryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DictionaryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DictionaryModel copyWith({
    String? word,
    List<Phonetic>? phonetics,
    List<Meaning>? meanings,
    License? license,
    List<String>? sourceUrls,
  }) {
    return DictionaryModel(
      word: word ?? this.word,
      phonetics: phonetics ?? this.phonetics,
      meanings: meanings ?? this.meanings,
      license: license ?? this.license,
      sourceUrls: sourceUrls ?? this.sourceUrls,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      word,
      phonetics,
      meanings,
      license,
      sourceUrls,
    ];
  }
}
