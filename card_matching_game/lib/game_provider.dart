import 'package:flutter/material.dart';

class CardModel {
  final String id;
  final IconData icon;
  bool isFaceUp;

  CardModel({required this.id, required this.icon, this.isFaceUp = false});
}

class GameProvider with ChangeNotifier {
  List<CardModel> _cards = [];
  CardModel? _firstCard;
  CardModel? _secondCard;
  bool _isGameWon = false;

  GameProvider() {
    _initializeCards();
  }

  List<CardModel> get cards => _cards;
  bool get isGameWon => _isGameWon;

  void _initializeCards() {
    List<IconData> icons = [
      Icons.ac_unit,
      Icons.cake,
      Icons.local_florist,
      Icons.star,
      Icons.favorite,
      Icons.home,
      Icons.pets,
      Icons.airplanemode_active,
      Icons.ac_unit,
      Icons.cake,
      Icons.local_florist,
      Icons.star,
      Icons.favorite,
      Icons.home,
      Icons.pets,
      Icons.airplanemode_active,
    ];

    _cards = icons.asMap().entries.map((entry) {
      return CardModel(id: entry.key.toString(), icon: entry.value);
    }).toList();
    _cards.shuffle();
    _isGameWon = false;
  }

  void flipCard(int index) {
    if (_firstCard == null) {
      _firstCard = _cards[index];
      _firstCard!.isFaceUp = true;
    } else if (_secondCard == null && _firstCard!.id != _cards[index].id) {
      _secondCard = _cards[index];
      _secondCard!.isFaceUp = true;
      notifyListeners();

      Future.delayed(Duration(seconds: 1), () {
        if (_firstCard!.icon != _secondCard!.icon) {
          _firstCard!.isFaceUp = false;
          _secondCard!.isFaceUp = false;
        } else {
          _checkWinCondition();
        }
        _firstCard = null;
        _secondCard = null;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void _checkWinCondition() {
    if (_cards.every((card) => card.isFaceUp)) {
      _isGameWon = true;
      notifyListeners();
    }
  }

  void restartGame() {
    _initializeCards();
    notifyListeners();
  }
}
