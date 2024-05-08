import 'package:app/shared/models/credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class CreditCardDatabase with ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([CreditCardSchema], directory: dir.path);
  }

  late List<CreditCard> _creditCardList = [];

  Future<void> getSavedCardsOfUser(String username) async {
    final List<CreditCard> newSavedCards = await isar.creditCards
        .filter()
        .usernameMatches(username, caseSensitive: true)
        .findAll();

    _creditCardList.clear();
    _creditCardList.addAll(newSavedCards);
    notifyListeners();
  }

  Future<void> saveCard(
    String username, {
    required String number,
    required String holderName,
    required String expiryDate,
    required String cvv,
  }) async {
    CreditCard newCard = CreditCard();
    newCard.username = username;
    newCard.holderName = holderName;
    newCard.number = number;
    newCard.expiryDate = expiryDate;
    newCard.cvv = cvv;

    await isar.writeTxn(() => isar.creditCards.put(newCard));
    await getSavedCardsOfUser(username);
  }

  Future<void> deleteCard(String username, String number) async {
    final CreditCard? card = await isar.creditCards
        .where()
        .filter()
        .numberMatches(number, caseSensitive: false)
        .findFirst();
    if (card != null) {
      await isar.creditCards.delete(card.id);
    }
    await getSavedCardsOfUser(username);
  }

  List<CreditCard> get cards => _creditCardList;
}
