import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'word_guess_game.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final WordGuessGame _game = WordGuessGame();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    _controller.addListener(() {
      final text = _controller.text.toUpperCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(
          baseOffset: text.length,
          extentOffset: text.length,
        ),
        composing: TextRange.empty,
      );
    });
  }

  void _guessLetter() {
    setState(() {
      _game.guessLetter(_controller.text);
      _controller.clear();
      _focusNode.requestFocus();
      if (_game.isGameOver()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              isWin: _game.isWin(),
              onPlayAgain: _playAgain,
            ),
          ),
        );
      }
    });
  }

  void _playAgain() {
    if (mounted) {
      setState(() {
        _game.resetGame();
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Guess Game')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _game.currentWord.split('').map((letter) {
                return _game.guessedLetters.contains(letter) ? letter : '_';
              }).join(' '),
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            Text('Hint: ${_game.currentHint}'),
            const SizedBox(height: 20),
            Text('Guessed Letters: ${_game.guessedLetters.join(', ')}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _game.maxWrongGuesses,
                    (index) => Icon(
                  index < _game.wrongGuesses ? Icons.favorite_border : Icons.favorite,
                  color: index < _game.wrongGuesses ? Colors.black12 : Colors.red,
                ),
              ).reversed.toList(),
            ),
            const SizedBox(height: 20),
            Container(
              width: 50,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                textAlign: TextAlign.center,
                onSubmitted: (_) => _guessLetter(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  LengthLimitingTextInputFormatter(1),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guessLetter,
              child: const Text('Guess'),
            ),
          ],
        ),
      ),
    );
  }
}