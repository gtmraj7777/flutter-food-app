final String tableOrders = 'orders';

class OrderFileds {
  static final List<String> values = [
    id,
    foodImage,
    foodName,
    foodPrice,
    foodQuantity,
    foodTotalPrice
  ];

  static final String id = '_id';
  static final String foodImage = 'foodImage';
  static final String foodName = 'foodName';
  static final String foodPrice = 'foodPrice';
  static final String foodQuantity = 'foodQuantity';
  static final String foodTotalPrice = 'foodTotalPrice';
}

class Order {
  final int? id;
  final String foodImage;
  final String foodName;
  final String foodPrice;
  final String foodQuantity;
  final String foodTotalPrice;

  Order(
      {this.id,
      required this.foodImage,
      required this.foodName,
      required this.foodPrice,
      required this.foodQuantity,
      required this.foodTotalPrice});

  Order copy({
    int? id,
    String? foodImage,
    String? foodName,
    String? foodPrice,
    String? foodQuantity,
    String? foodTotalPrice,
  }) =>
      Order(
        id: id ?? this.id,
        foodImage: foodImage ?? this.foodImage,
        foodName: foodName ?? this.foodName,
        foodPrice: foodPrice ?? this.foodPrice,
        foodQuantity: foodQuantity ?? this.foodQuantity,
        foodTotalPrice: foodTotalPrice ?? this.foodTotalPrice,
      );

  static Order fromJson(Map<String, Object?> json) => Order(
        id: json[OrderFileds.id] as int?,
        foodImage: json[OrderFileds.foodImage] as String,
        foodName: json[OrderFileds.foodName] as String,
        foodPrice: json[OrderFileds.foodPrice] as String,
        foodQuantity: json[OrderFileds.foodQuantity] as String,
        foodTotalPrice: json[OrderFileds.foodTotalPrice] as String,
      );

  Map<String, Object?> toJson() => {
        OrderFileds.id: id,
        OrderFileds.foodImage: foodImage,
        OrderFileds.foodName: foodName,
        OrderFileds.foodPrice: foodPrice,
        OrderFileds.foodQuantity: foodQuantity,
        OrderFileds.foodTotalPrice: foodTotalPrice,
      };
}
