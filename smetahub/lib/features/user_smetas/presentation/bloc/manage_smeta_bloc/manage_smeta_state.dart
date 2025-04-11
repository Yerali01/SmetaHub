part of 'manage_smeta_bloc.dart';

abstract class ManageSmetaState {}

class ManageSmetaInitial extends ManageSmetaState {}

class ShowManageSmetaState extends ManageSmetaState {
  final List<List<dynamic>> estimateItems;
  final List<UnitModel> units;
  final int estimateId;
  final String? sortingType;

  ShowManageSmetaState({
    required this.estimateItems,
    required this.units,
    required this.estimateId,
    this.sortingType,
  });

  ShowManageSmetaState copyWith({
    List<List<dynamic>>? estimateItems,
    List<UnitModel>? units,
    int? estimateId,
    String? sortingType,
  }) {
    return ShowManageSmetaState(
      estimateItems: estimateItems ?? this.estimateItems,
      units: units ?? this.units,
      estimateId: estimateId ?? this.estimateId,
      sortingType: sortingType ?? this.sortingType,
    );
  }
}

class UpdateItemsSuccessState extends ManageSmetaState {}
