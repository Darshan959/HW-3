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
                  Text(
                    'Congratulations! You matched all pairs!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
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

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: game.cards.length,
            itemBuilder: (context, index) {
              return CardWidget(index: index);
            },
          );
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int index;

  CardWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    final card = Provider.of<GameProvider>(context).cards[index];
    return GestureDetector(
      onTap: () {
        Provider.of<GameProvider>(context, listen: false).flipCard(index);
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: card.isFaceUp
            ? Container(
                key: ValueKey(true),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    card.icon,
                    size: 48.0,
                    color: Colors.black,
                  ),
                ),
              )
            : Container(
                key: ValueKey(false),
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
      ),
    );
  }
}
