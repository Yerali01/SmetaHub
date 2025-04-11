part of 'create_estimate_item_bloc.dart';

abstract class CreateEstimateItemEvent {}

class InitCreateEstimateItemEvent extends CreateEstimateItemEvent {}

class ChangeEstimatePropertiesEvent extends CreateEstimateItemEvent {
  final String? workType;
  final String? unit;
  final double? quantity;
  final double? pricePerOne;
  final double? clientPricePerOne;
  final double? cost;
  final double? clientCost;
  final double? markup;

  ChangeEstimatePropertiesEvent({
    this.workType,
    this.unit,
    this.quantity,
    this.pricePerOne,
    this.clientPricePerOne,
    this.cost,
    this.clientCost,
    this.markup,
  });
}

class AddEstimateItemEvent extends CreateEstimateItemEvent {
  final int estimateId;
  final String positionName;

  final EstimateItemModel item;

  AddEstimateItemEvent({
    required this.estimateId,
    required this.positionName,
    required this.item,
  });
}
