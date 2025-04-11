part of 'create_estimate_item_bloc.dart';

abstract class CreateEstimateItemState {}

class ShowCreateEstimateItemState extends CreateEstimateItemState {
  final String workType;
  final String unit;
  final double quantity;
  final double pricePerOne;
  final double clientPricePerOne;
  final double cost;
  final double clientCost;
  final double markup;

  final List<UnitModel> units;
  final List<WorkIconModel> worksAndIcons;

  ShowCreateEstimateItemState({
    required this.workType,
    required this.unit,
    required this.quantity,
    required this.pricePerOne,
    required this.clientPricePerOne,
    required this.cost,
    required this.clientCost,
    required this.markup,
    required this.units,
    required this.worksAndIcons,
  });

  ShowCreateEstimateItemState copyWith({
    String? workType,
    String? unit,
    double? quantity,
    double? pricePerOne,
    double? clientPricePerOne,
    double? cost,
    double? clientCost,
    double? markup,
    List<UnitModel>? units,
    List<WorkIconModel>? worksAndIcons,
  }) {
    return ShowCreateEstimateItemState(
      workType: workType ?? this.workType,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      pricePerOne: pricePerOne ?? this.pricePerOne,
      clientPricePerOne: clientPricePerOne ?? this.clientPricePerOne,
      cost: cost ?? this.cost,
      clientCost: clientCost ?? this.clientCost,
      markup: markup ?? this.markup,
      units: units ?? this.units,
      worksAndIcons: worksAndIcons ?? this.worksAndIcons,
    );
  }
}

class AddEstimateItemSuccessState extends CreateEstimateItemState {}
