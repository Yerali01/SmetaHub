class EstimateItemModel {
  final int itemId;
  final String workType;
  final String unit;
  final double quantity;
  final double pricePerOne;
  final double clientPricePerOne;
  final double cost;
  final double clientCost;
  final double markup;

  EstimateItemModel({
    required this.itemId,
    required this.workType,
    required this.unit,
    required this.quantity,
    required this.pricePerOne,
    required this.clientPricePerOne,
    required this.cost,
    required this.clientCost,
    required this.markup,
  });

  factory EstimateItemModel.fromJson(Map<String, dynamic> json) {
    return EstimateItemModel(
      itemId: json["id"],
      workType: json["work_type"],
      unit: json["unit"],
      quantity: json["quantity"],
      pricePerOne: json["price_per_one"],
      clientPricePerOne: json["client_price_per_one"],
      cost: json["cost"],
      clientCost: json["client_cost"],
      markup: json['markup'],
    );
  }

  EstimateItemModel copyWith({
    int? itemId,
    String? workType,
    String? unit,
    double? quantity,
    double? pricePerOne,
    double? clientPricePerOne,
    double? cost,
    double? clientCost,
    double? markup,
  }) {
    return EstimateItemModel(
      itemId: itemId ?? this.itemId,
      workType: workType ?? this.workType,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      pricePerOne: pricePerOne ?? this.pricePerOne,
      clientPricePerOne: clientPricePerOne ?? this.clientPricePerOne,
      cost: cost ?? this.cost,
      clientCost: clientCost ?? this.clientCost,
      markup: markup ?? this.markup,
    );
  }
}
