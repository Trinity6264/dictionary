import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'license.dart';

class Phonetic extends Equatable {
  final String? audio;
  final String? sourceUrl;
  final License? license;
  final String? text;

  const Phonetic({this.audio, this.sourceUrl, this.license, this.text});

  factory Phonetic.fromMap(Map<String, dynamic> data) => Phonetic(
        audio: data['audio'] as String?,
        sourceUrl: data['sourceUrl'] as String?,
        license: data['license'] == null
            ? null
            : License.fromMap(data['license'] as Map<String, dynamic>),
        text: data['text'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'audio': audio,
        'sourceUrl': sourceUrl,
        'license': license?.toMap(),
        'text': text,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Phonetic].
  factory Phonetic.fromJson(String data) {
    return Phonetic.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Phonetic] to a JSON string.
  String toJson() => json.encode(toMap());

  Phonetic copyWith({
    String? audio,
    String? sourceUrl,
    License? license,
    String? text,
  }) {
    return Phonetic(
      audio: audio ?? this.audio,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      license: license ?? this.license,
      text: text ?? this.text,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [audio, sourceUrl, license, text];
}
