// lib/providers/bill_provider.dart
import 'package:flutter/material.dart';
import 'purchased_item.dart';

class BillProvider with ChangeNotifier {
  final List<PurchasedItem> _purchasedItems = [];

  List<PurchasedItem> get purchasedItems => List.unmodifiable(_purchasedItems);

  int get totalBill {
    return _purchasedItems.fold(0, (sum, item) => sum + item.price);
  }

  void addItem(PurchasedItem item) {
    _purchasedItems.add(item);
    notifyListeners();
  }

  void clearBill() {
    _purchasedItems.clear();
    notifyListeners();
  }
}
