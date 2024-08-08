import 'dart:math';

class WordGuessGame {
  final Map<String, String> _words = {
    'MAPLE': 'A type of tree known for its syrup.',
    'QUARTZ': 'A common mineral often used in watches.',
    'COBRA': 'A venomous snake with a hood.',
    'FALCON': 'A bird known for its speed in flight.',
    'DENIM': 'A durable fabric used in jeans.',
    'ORBIT': 'The path of a planet around the sun.',
    'GLACIER': 'A large, slow-moving mass of ice.',
    'AMBER': 'A fossilized tree resin often used in jewelry.',
    'PIXEL': 'The smallest unit of a digital image.',
    'LILAC': 'A flower known for its purple color and fragrance.',
    'RAVEN': 'A large black bird associated with mystery.',
    'FABLE': 'A short story with a moral, often featuring animals.',
    'PECAN': 'A type of nut often used in pies.',
    'CIPHER': 'A coded message or a method of encryption.',
    'LLAMA': 'A domesticated South American pack animal.',
    'OASIS': 'A fertile spot in a desert with water.',
    'TUNDRA': 'A cold, treeless biomes with permafrost.',
    'KARMA': 'The concept of cause and effect in actions.',
    'IGLOO': 'A dome-shaped Eskimo house made of snow.',
    'NINJA': 'A covert agent or mercenary in feudal Japan.'
  };
  late String _currentWord;
  late String _currentHint;
  Set<String> _guessedLetters = {};
  int _wrongGuesses = 0;
  final int _maxWrongGuesses = 6;

  WordGuessGame() {
    _startNewGame();
  }

  void _startNewGame() {
    var wordEntry = _words.entries.elementAt(Random().nextInt(_words.length));
    _currentWord = wordEntry.key;
    _currentHint = wordEntry.value;
    _guessedLetters.clear();
    _wrongGuesses = 0;
  }

  String get currentWord => _currentWord;

  String get currentHint => _currentHint;

  Set<String> get guessedLetters => _guessedLetters;

  int get wrongGuesses => _wrongGuesses;

  int get maxWrongGuesses => _maxWrongGuesses;

  bool guessLetter(String letter) {
    if (_guessedLetters.contains(letter)) return false;
    _guessedLetters.add(letter);
    if (!_currentWord.contains(letter)) {
      _wrongGuesses++;
    }
    return true;
  }

  bool isGameOver() {
    return _wrongGuesses >= _maxWrongGuesses || _isWordGuessed();
  }

  bool _isWordGuessed() {
    for (var letter in _currentWord.split('')) {
      if (!_guessedLetters.contains(letter)) return false;
    }
    return true;
  }

  bool isWin() {
    return _isWordGuessed();
  }

  void resetGame() {
    _startNewGame();
  }
}
