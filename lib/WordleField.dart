import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle/main.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class WordleField extends StatefulWidget {
  final LetterState? state;
  final bool shouldFocus;
  final Function(String) onChanged;
  const WordleField({
    Key? key,
    this.state,
    required this.shouldFocus,
    required this.onChanged
  }) : super(key: key);

  @override
  State<WordleField> createState() => _WordleFieldState();
}

class _WordleFieldState extends State<WordleField> {

  FocusNode node = FocusNode();


  @override
  void didUpdateWidget(WordleField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.shouldFocus){
      node.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? color = switch(widget.state){
      LetterState.isIndexCorrect => Colors.green,
      LetterState.isLetterCorrect => Colors.yellow,
      LetterState.incorrect => Colors.red,
      null => null
    };
    return TextField(
      focusNode: node,
      decoration: InputDecoration(
        filled: true,
        fillColor: color,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFF07ADE))),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        contentPadding: EdgeInsets.zero,
      ),
      textCapitalization:
      TextCapitalization.characters,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        UpperCaseTextFormatter()
      ],
      style: const TextStyle(fontSize: 40, color: Colors.white),
      textAlign: TextAlign.center,
      showCursor: false,
      onChanged: widget.onChanged,
    );
  }
}
