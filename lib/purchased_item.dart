// lib/models/purchased_item.dart

/// This class represents an item purchased by the user, such as a hotel room.
class PurchasedItem {
  final String hotelName;  // The name of the hotel
  final String roomType;   // Type of room selected (e.g., "2 Bed Room")
  final int price;         // Price of the selected room

  /// Creates a [PurchasedItem] with the specified hotel name, room type, and price.
  PurchasedItem({
    required this.hotelName,
    required this.roomType,
    required this.price,
  });

  /// A convenience method to convert a [PurchasedItem] to a Map,
  /// which can be useful for storage or network requests.
  Map<String, dynamic> toMap() {
    return {
      'hotelName': hotelName,
      'roomType': roomType,
      'price': price,
    };
  }

  /// Factory method to create a [PurchasedItem] from a Map,
  /// which can be useful when retrieving data from storage.
  factory PurchasedItem.fromMap(Map<String, dynamic> map) {
    return PurchasedItem(
      hotelName: map['hotelName'],
      roomType: map['roomType'],
      price: map['price'],
    );
  }
}
