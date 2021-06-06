import 'package:flutter/cupertino.dart';
import 'package:flutter_animated_cards/database/database_service.dart';
import 'package:flutter_animated_cards/network/api_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final provider = Provider<Notifier>((ref) => Notifier());

class Notifier extends ChangeNotifier {
  bool isFavourite = false;
  final DatabaseHelper databaseHelper = DatabaseHelper();





  void saveQuote(Quote quote) {
    databaseHelper.saveQuote(quote);
    isFavourite = true;
    notifyListeners();
  }

  void removeQuote(int? id) {
    databaseHelper.deleteQuote(id!);
    isFavourite = false;
    notifyListeners();
  }
}
