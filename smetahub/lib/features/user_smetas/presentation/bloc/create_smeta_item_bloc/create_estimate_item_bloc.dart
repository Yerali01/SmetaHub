import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/features/home/domain/entity/unit_model.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';
import 'package:smetahub/features/user_smetas/domain/models/work_icon_model.dart';
import 'package:smetahub/repository/app_repository.dart';

part 'create_estimate_item_event.dart';
part 'create_estimate_item_state.dart';

class CreateEstimateItemBloc
    extends Bloc<CreateEstimateItemEvent, CreateEstimateItemState> {
  CreateEstimateItemBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowCreateEstimateItemState(
            workType: '',
            unit: '',
            quantity: 0,
            pricePerOne: 0,
            clientPricePerOne: 0,
            cost: 0,
            clientCost: 0,
            markup: 0,
            units: [],
            worksAndIcons: [],
          ),
        ) {
    on<InitCreateEstimateItemEvent>(_initCreateEstimateItem);
    on<ChangeEstimatePropertiesEvent>(_changeEstimateQuantity);

    on<AddEstimateItemEvent>(_addEstimateItem);
  }

  final AppRepository _appRepository;

  Future<void> _initCreateEstimateItem(
    final InitCreateEstimateItemEvent event,
    final Emitter<CreateEstimateItemState> emit,
  ) async {
    try {
      final ShowCreateEstimateItemState state =
          this.state as ShowCreateEstimateItemState;

      final res = await _appRepository.getWorkTypes();
      List<WorkIconModel> relevantWorkIcons = [];

      if (res["work_types"].isNotEmpty) {
        for (int i = 0; i < res["work_types"].length; i++) {
          relevantWorkIcons.add(
            WorkIconModel(
              workType: res["work_types"][i]['name'],
            ),
          );
        }
      }

      emit(
        state.copyWith(
          units: _appRepository.units.valueOrNull ?? [],
          worksAndIcons: relevantWorkIcons,
        ),
      );
    } on Exception catch (e) {
      log('Ошибка!!! _initCreateEstimateItem = $e');
    }
  }

  Future<void> _changeEstimateQuantity(
    final ChangeEstimatePropertiesEvent event,
    final Emitter<CreateEstimateItemState> emit,
  ) async {
    try {
      final ShowCreateEstimateItemState state =
          this.state as ShowCreateEstimateItemState;

      emit(
        state.copyWith(
          quantity: event.quantity ?? state.quantity,
          workType: event.workType ?? state.workType,
          unit: event.unit ?? state.unit,
          pricePerOne: event.pricePerOne ?? state.pricePerOne,
          clientPricePerOne: event.clientPricePerOne ?? state.clientPricePerOne,
          cost: event.cost ?? state.cost,
          clientCost: event.clientCost ?? state.clientCost,
          markup: event.markup ?? state.markup,
        ),
      );
    } on Exception catch (e) {
      log('Ошибка!!! _updateEstimateItems = $e');
    }
  }

  Future<void> _addEstimateItem(
    final AddEstimateItemEvent event,
    final Emitter<CreateEstimateItemState> emit,
  ) async {
    try {
      final res = await _appRepository.addEstimateItem(
        estimateId: event.estimateId,
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
