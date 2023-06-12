import 'package:flutter/material.dart';
import 'package:wordle/main.dart';
import 'package:wordle/wordle_alert_dialog.dart';

import 'WordleField.dart';

class Word extends StatefulWidget {
  final String correctWord;
  final bool check;
  final int currentAttempt;

  const Word({
    Key? key,
    required this.correctWord,
    required this.check,
    required this.currentAttempt,
  }) : super(key: key);

  @override
  State<Word> createState() => _WordState();
}

class _WordState extends State<Word> {
  List<String?> currentWord = List.generate(5, (index) => null);
  List<LetterState?> textFieldStates = List.generate(5, (_) => null);
  var isWordCorrect = false;

  @override
  void didUpdateWidget(Word oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.check != oldWidget.check) && widget.check) {
      checkWord(widget.correctWord.toUpperCase());
    }
  }

  void checkWord(String word) {
    for (int i = 0; i < 5; i++) {
      if (word[i] == currentWord[i]) {
        textFieldStates[i] = LetterState.isIndexCorrect;
      } else if (currentWord[i] != null && word.contains(currentWord[i]!)) {
        textFieldStates[i] = LetterState.isLetterCorrect;
      } else {
        textFieldStates[i] = LetterState.incorrect;
      }
    }
    isWordCorrect = textFieldStates
        .every((element) => element == LetterState.isIndexCorrect);

    if (widget.currentAttempt == 0 && !isWordCorrect) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WordleAlertDialog(
              title: "Game Over",
              text: "The correct word is: ",
              correctWord: widget.correctWord);
        },
      );
    } else if (isWordCorrect) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return WordleAlertDialog(
              title: "You Win!",
              text: "The correct word is: ",
              correctWord: widget.correctWord);
        },
      );
    }
    else{
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> letters = [];
    for (var l = 0; l < 5; l++) {
      letters.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: WordleField(
              state: textFieldStates[l],
              shouldFocus: false,
              onChanged: (value) {
                currentWord[l] = value;
              },
            ),
          ),
        ),
      );
    }

    return Row(children: letters);
  }
}
