class OrderModel {
  int status;
  String message;
  List<Order> order;

  OrderModel({
    required this.status,
    required this.message,
    required this.order,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        message: json["message"],
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
      );
}

class Order {
  String id;
  DateTime orderDate;
  List<Item> items;
  num totalPrice;
  Customer shop;
  Customer customer;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Order({
    required this.id,
    required this.orderDate,
    required this.items,
    required this.totalPrice,
    required this.shop,
    required this.customer,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        orderDate: DateTime.parse(json["order_date"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalPrice: json["total_price"],
        shop: Customer.fromJson(json["shop"]),
        customer: Customer.fromJson(json["customer"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Customer {
  String id;
  String name;
  String email;

  Customer({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
      };
}

class Item {
  String id;
  Food food;
  int quantity;

  Item({
    required this.id,
    required this.food,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        food: Food.fromJson(json["food"]),
        quantity: json["quantity"],
      );
}

class Food {
  String id;
  String name;
  String description;
  num price;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
      );
}