class DictionaryModel {
  String? word;
  String? phonetic;
  List<Phonetics>? phonetics;
  List<Meaning>? meanings;
  License? license;
  List<String>? sourceUrls;

  DictionaryModel({
    this.word,
    this.phonetic,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  DictionaryModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    phonetic = json['phonetic'];
    if (json['phonetics'] != null) {
      phonetics = <Phonetics>[];
      json['phonetics'].forEach((v) {
        phonetics!.add(Phonetics.fromJson(v));
      });
    }
    if (json['meanings'] != null) {
      meanings = <Meaning>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meaning.fromJson(v));
      });
    }
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
    sourceUrls = json['sourceUrls']?.cast<String>();
  }
}

class Phonetics {
  String? audio;
  String? text;
  String? sourceUrl;
  License? license;

  Phonetics({
    this.audio,
    this.text,
    this.sourceUrl,
    this.license,
  });

  Phonetics.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    text = json['text'];
    sourceUrl = json['sourceUrl'];
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
  }
}

class Meaning {
  String? partOfSpeech;
  List<Definition>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  Meaning.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    if (json['definitions'] != null) {
      definitions = <Definition>[];
      json['definitions'].forEach((v) {
        definitions!.add(Definition.fromJson(v));
      });
    }
    synonyms = json['synonyms']?.cast<String>();
    antonyms = json['antonyms']?.cast<String>();
  }
}

class Definition {
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;

  Definition({
    this.definition,
    this.synonyms,
    this.antonyms,
    this.example,
  });

  Definition.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    synonyms = json['synonyms']?.cast<String>();
    antonyms = json['antonyms']?.cast<String>();
    example = json['example'];
  }
}

class License {
  String? name;
  String? url;

  License({
    this.name,
    this.url,
  });

  License.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
