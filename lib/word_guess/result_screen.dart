import 'package:flutter/material.dart';

import 'game_screen.dart';

class ResultScreen extends StatelessWidget {
  final bool isWin;
  final VoidCallback onPlayAgain;

  ResultScreen({required this.isWin, required this.onPlayAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isWin ? 'assets/images/win.png' : 'assets/images/lost.png',
              width: 300,
              height: 300,
            ),
            ElevatedButton(
              onPressed: () {
                onPlayAgain();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4267DF), // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}