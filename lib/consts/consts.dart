class Constante {
  final int maxTries = 10;
  final String textGuess = 'I\'m thinking of a number between 1 and 100.';
  final String textGuess2 = 'It\'s your turn to guess my number!';
  final String textTries = 'Tries';

  String textResult;
  String guessReset;
  String guess;

  int tries;

  bool isGuessed;
  bool isPressed;
  bool isEnabled;
  Constante({
    required this.textResult,
    required this.guessReset,
    required this.guess,
    required this.tries,
    required this.isGuessed,
    required this.isPressed,
    required this.isEnabled,
  });
}
