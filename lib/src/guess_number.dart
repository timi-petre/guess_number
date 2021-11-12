import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_number/consts/consts.dart';

void main() {
  runApp(const MyApp());
}

Constante consts = Constante(
  isGuessed: false,
  isEnabled: true,
  isPressed: false,
  tries: 0,
  guessReset: 'Guess',
  guess: '',
  textResult: '',
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guess Number',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[100],
      ),
      home: const GuessPage(title: 'Guess my Number'),
    );
  }
}

class GuessPage extends StatefulWidget {
  const GuessPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  final FocusNode _focusNode = FocusNode();
  final textController = TextEditingController();

  int randomNumber = Random().nextInt(99) + 1;

  @override
  void dispose() {
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  consts.textGuess,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  consts.textGuess2,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (consts.isPressed)
                  Column(
                    children: [
                      Text(
                        consts.guess,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        consts.textResult,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                Card(
                  shape: const StadiumBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Try a number!',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        TextField(
                          enabled: consts.isEnabled,
                          focusNode: _focusNode,
                          style: const TextStyle(fontSize: 20),
                          maxLength: 2,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          controller: textController,
                          decoration: InputDecoration(
                            counterStyle: const TextStyle(
                              color: Colors.teal,
                              fontSize: 15,
                            ),
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                });
                                textController.clear();
                              },
                            ),
                            counterText:
                                '${consts.tries} / ${consts.maxTries} ${consts.textTries}',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          child: Text(consts.guessReset),
                          onPressed: () {
                            print(randomNumber);
                            final String value = textController.text;
                            final int? intValue = int.tryParse(value);
                            consts.isPressed = true;
                            setState(() {
                              if (intValue != null) {
                                if (intValue == randomNumber) {
                                  consts.textResult = 'You guessed right!';
                                  consts.guessReset = 'Reset';
                                  consts.guess = 'You tried $intValue';
                                  consts.isGuessed = true;
                                  consts.tries = 0;
                                  randomNumber = Random().nextInt(99) + 1;
                                  textController.clear();
                                  FocusScope.of(context).unfocus();
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('You guessed right!'),
                                      content: Text('It was $intValue'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Try Again!'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            consts.isEnabled = false;
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  consts.textResult =
                                      int.parse(value) > randomNumber
                                          ? 'Try Lower!'
                                          : 'Try Higher!';
                                  consts.guess = 'You tried $intValue';
                                  consts.isGuessed = false;
                                  consts.tries++;
                                  textController.clear();
                                }
                              } else {
                                textController.clear();
                                consts.guessReset = 'Guess';
                                consts.isPressed = false;
                                consts.isEnabled = true;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
