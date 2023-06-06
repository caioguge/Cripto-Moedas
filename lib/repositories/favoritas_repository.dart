import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/moeda.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Moeda> _lista = [];

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moeda> moedas) {
    // ignore: avoid_function_literals_in_foreach_calls
    moedas.forEach((moeda) {
      if (!_lista.contains(moeda)) {
        _lista.add(moeda);
      }
    });
    notifyListeners();
  }

  remove(Moeda moeda) {
    _lista.remove(moeda);
    notifyListeners();
  }
}
