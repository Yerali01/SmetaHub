part of 'manage_smeta_bloc.dart';

abstract class ManageSmetaState {}

class ManageSmetaInitial extends ManageSmetaState {}

class ShowManageSmetaState extends ManageSmetaState {
  final List<List<dynamic>> estimateItems;
  final List<UnitModel> units;
  final int estimateId;

  ShowManageSmetaState({
    required this.estimateItems,
    required this.units,
    required this.estimateId,
  });

  ShowManageSmetaState copyWith({
    List<List<dynamic>>? estimateItems,
    List<UnitModel>? units,
    int? estimateId,
  }) {
    return ShowManageSmetaState(
      estimateItems: estimateItems ?? this.estimateItems,
      units: units ?? this.units,
      estimateId: estimateId ?? this.estimateId,
    );
  }
}

class UpdateItemsSuccessState extends ManageSmetaState {}

class AddEstimateItemSuccessState extends ManageSmetaState {}
