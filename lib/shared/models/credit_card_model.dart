import 'package:isar/isar.dart';

part 'credit_card_model.g.dart';

@Collection()
class CreditCard {
  final Id id = Isar.autoIncrement;

  late String username;
  late String number;
  late String holderName;
  late String expiryDate;
  late String cvv;
}
