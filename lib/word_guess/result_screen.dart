import 'package:flutter/material.dart';

import 'game_screen.dart';

class ResultScreen extends StatelessWidget {
  final bool isWin;
  final VoidCallback onPlayAgain;

  ResultScreen({required this.isWin, required this.onPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Over')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isWin ? 'You WON!' : 'You LOST!',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onPlayAgain();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}