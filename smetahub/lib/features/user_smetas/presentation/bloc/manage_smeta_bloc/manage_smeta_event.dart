part of 'manage_smeta_bloc.dart';

abstract class ManageSmetaEvent {}

class GetEstimateInfo extends ManageSmetaEvent {
  final int estimateId;

  GetEstimateInfo({required this.estimateId});
}

class UpdateEstimateItemsEvent extends ManageSmetaEvent {}

class ChangeEstimatePropertiesEvent extends ManageSmetaEvent {
  final int itemId;
  final String? workType;
  final String? unit;
  final double? quantity;
  final double? pricePerOne;
  final double? clientPricePerOne;
  final double? cost;
  final double? clientCost;
  final double? markup;

  ChangeEstimatePropertiesEvent({
    required this.itemId,
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

class SelectSortingTypeEvent extends ManageSmetaEvent {
  final String sortingType;

  SelectSortingTypeEvent({
    required this.sortingType,
  });
}
