class CartItem {
  final int? id;
  final int productId;
  final String productName;
  final double price;
  final int quantity;

  CartItem({
    this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      productId: map['productId'],
      productName: map['productName'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
