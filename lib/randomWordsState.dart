import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'randomWords.dart';

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
