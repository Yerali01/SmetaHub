import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/home/domain/entity/unit_model.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'manage_smeta_event.dart';
part 'manage_smeta_state.dart';

class ManageSmetaBloc extends Bloc<ManageSmetaEvent, ManageSmetaState> {
  ManageSmetaBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowManageSmetaState(
            estimateId: 0,
            estimateItems: [],
            units: [],
          ),
        ) {
    on<GetEstimateInfo>(_getEstimateInfo);
    on<UpdateEstimateItemsEvent>(_updateEstimateItems);

    on<ChangeEstimatePropertiesEvent>(_changeEstimateQuantity);

    on<AddEstimateItemEvent>(_addEstimateItem);
  }

  final AppRepository _appRepository;

  Future<void> _getEstimateInfo(
    final GetEstimateInfo event,
    final Emitter<ManageSmetaState> emit,
  ) async {
    try {
      final ShowManageSmetaState state = this.state as ShowManageSmetaState;
      final res = await _appRepository.getEstimateInfo(
        estimateId: event.estimateId,
      );

      if (res["items"] != null) {
        final List<List<dynamic>> estimateItems = [];
        for (int i = 0; i < res["items"].length; i++) {
          estimateItems
              .add([true, EstimateItemModel.fromJson(res["items"][i])]);
        }

        if (_appRepository.units.valueOrNull != null) {
          emit(
            state.copyWith(
              estimateItems: estimateItems,
              estimateId: event.estimateId,
              units: _appRepository.units.value,
            ),
          );
        } else {
          emit(
            state.copyWith(
              estimateItems: estimateItems,
              estimateId: event.estimateId,
            ),
          );
        }
      }
    } on Exception catch (e) {
      log('Ошибка!!! _getEstimateInfo = $e');
    }
  }

  Future<void> _updateEstimateItems(
    final UpdateEstimateItemsEvent event,
    final Emitter<ManageSmetaState> emit,
  ) async {
    try {
      final ShowManageSmetaState state = this.state as ShowManageSmetaState;
      final List<Map<String, dynamic>> finalEstimateItems = [];
      for (int i = 0; i < state.estimateItems.length; i++) {
        if (state.estimateItems[i][1] != null) {
          finalEstimateItems.add(
            {
              "id": state.estimateItems[i][1].itemId,
              "work_type": state.estimateItems[i][1].workType,
              "unit": state.estimateItems[i][1].unit,
              "quantity": state.estimateItems[i][1].quantity,
              "price_per_one": state.estimateItems[i][1].pricePerOne,
              "cost": state.estimateItems[i][1].cost,
              "markup": state.estimateItems[i][1].markup,
              "client_price_per_one":
                  state.estimateItems[i][1].clientPricePerOne,
              "client_cost": state.estimateItems[i][1].clientCost,
            },
          );
        }
      }
      log('ESTIMATE ITEMS ${finalEstimateItems}');

      final res = await _appRepository.updateEstimateItems(
        estimateId: state.estimateId,
        estimateItems: finalEstimateItems,
      );

      if (res["success"] == true) {
        emit(
          UpdateItemsSuccessState(),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _updateEstimateItems = $e');
    }
  }

  Future<void> _changeEstimateQuantity(
    final ChangeEstimatePropertiesEvent event,
    final Emitter<ManageSmetaState> emit,
  ) async {
    try {
      final ShowManageSmetaState state = this.state as ShowManageSmetaState;

      final List<dynamic> estimateItem = state.estimateItems.where((item) {
        return item[1].itemId == event.itemId;
      }).first;

      final int changingIndex = state.estimateItems.indexOf(estimateItem);

      state.estimateItems[changingIndex] = [
        estimateItem[0],
        estimateItem[1].copyWith(
          quantity: event.quantity ?? estimateItem[1].quantity,
          workType: event.workType ?? estimateItem[1].workType,
          unit: event.unit ?? estimateItem[1].unit,
          pricePerOne: event.pricePerOne ?? estimateItem[1].pricePerOne,
          clientPricePerOne:
              event.clientPricePerOne ?? estimateItem[1].clientPricePerOne,
          cost: event.cost ?? estimateItem[1].cost,
          clientCost: event.clientCost ?? estimateItem[1].clientCost,
          markup: event.markup ?? estimateItem[1].markup,
        )
      ];

      log('CHANGED GOOD ${state.estimateItems[0][1].cost}');

      emit(state.copyWith());

      // log('ESTIMATE ITEM $estimateItem $changingIndex');
    } on Exception catch (e) {
      log('Ошибка!!! _updateEstimateItems = $e');
    }
  }

  Future<void> _addEstimateItem(
    final AddEstimateItemEvent event,
    final Emitter<ManageSmetaState> emit,
  ) async {
    try {
      final ShowManageSmetaState state = this.state as ShowManageSmetaState;
      final res = await _appRepository.addEstimateItem(
        estimateId: state.estimateId,
        estimateItem: event.item,
      );

      if (res["estimate_item"] != null) {
        emit(
          AddEstimateItemSuccessState(),
        );
      }
    } on Exception catch (e) {
      log('Ошибка!!! _addEstimateItem = $e');
    }
  }
}
