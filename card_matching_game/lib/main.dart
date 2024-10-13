import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: MaterialApp(
        title: 'Card Matching Game',
        home: GameScreen(),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Matching Game')),
      body: Consumer<GameProvider>(
        builder: (context, game, child) {
          if (game.isGameWon) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Congratulations! You matched all pairs!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      game.restartGame();
                    },
                    child: Text('Play Again'),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text('Game in Progress...'),
          );
        },
      ),
    );
  }
}
