class OrderModel {
  final int? status;
  final String? id;
  final List<Item>? items;
  final DateTime? createdAt;

  OrderModel({
    this.status,
    this.id,
    this.items,
    this.createdAt,
  });

  OrderModel copyWith({
    int? status,
    String? id,
    List<Item>? items,
    DateTime? createdAt,
  }) =>
      OrderModel(
        status: status ?? this.status,
        id: id ?? this.id,
        items: items ?? this.items,
        createdAt: createdAt ?? this.createdAt,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        id: json["id"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Item {
  final String? name;
  final num? price;
  final num? quantity;

  Item({
    this.name,
    this.price,
    this.quantity,
  });

  Item copyWith({
    String? name,
    num? price,
    num? quantity,
  }) =>
      Item(
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        price: json["price"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
      };
}
