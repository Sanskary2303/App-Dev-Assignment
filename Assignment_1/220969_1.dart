import 'dart:io';

void main() {
  List<String> articles = ['a', 'an', 'the'];

  int article = 0;
  int letter = 0;

  stdout.writeln("Write text");

  String text = stdin.readLineSync().toString();

  int characters = text.length;

  for (int i = 0; i < text.length; i++) {
    if (text[i].toLowerCase().contains(RegExp(r'[a-z]'))) {
      letter++;
    }
  }

  var words = text.split(" ");
  int word_count = words.length;

  List<String> sentence = text.split(RegExp(r'[.?!]'));
  sentence.removeWhere((sentence) => sentence.trim().isEmpty);
  int sentence_count = sentence.length;

  for (var word in words) {
    if (articles.contains(word.toLowerCase())) {
      article++;
    }
  }

  print("Characters : $characters");
  print("Letters : $letter");
  print("Words : $word_count");
  print("Sentences : $sentence_count");
  print("Articles : $article");
}
