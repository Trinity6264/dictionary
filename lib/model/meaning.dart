import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'definition.dart';

class Meaning extends Equatable {
  final String? partOfSpeech;
  final List<Definition>? definitions;
  final List<dynamic>? synonyms;
  final List<dynamic>? antonyms;

  const Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  factory Meaning.fromMap(Map<String, dynamic> data) => Meaning(
        partOfSpeech: data['partOfSpeech'] as String?,
        definitions: (data['definitions'] as List<dynamic>?)
            ?.map((e) => Definition.fromMap(e as Map<String, dynamic>))
            .toList(),
        synonyms: data['synonyms'] as List<dynamic>,
        antonyms: data['antonyms'],
      );

  Map<String, dynamic> toMap() => {
        'partOfSpeech': partOfSpeech,
        'definitions': definitions?.map((e) => e.toMap()).toList(),
        'synonyms': synonyms,
        'antonyms': antonyms,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Meaning].
  factory Meaning.fromJson(String data) {
    return Meaning.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Meaning] to a JSON string.
  String toJson() => json.encode(toMap());

  Meaning copyWith({
    String? partOfSpeech,
    List<Definition>? definitions,
    List<String>? synonyms,
    List<dynamic>? antonyms,
  }) {
    return Meaning(
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitions: definitions ?? this.definitions,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      partOfSpeech,
      definitions,
      synonyms,
      antonyms,
    ];
  }
}
