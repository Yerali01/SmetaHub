// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/core/models/error_handler_model.dart';

// Project imports:
part 'error_handler_event.dart';
part 'error_handler_state.dart';

/// Компонент Бизнес-Логики для управления сообщениями об ошибках
class ErrorHandlerBloc extends Bloc<ErrorHandlerEvent, ErrorHandlerState> {
  /// Конструктор и обработчик событий
  ErrorHandlerBloc() : super(ErrorHandlerInitialState()) {
    on<SubscribeErrorHandlerEvent>(_subscribe);
    on<ShowErrorHandlerEvent>(_showError);
  }

  /// Репозиторий для работы с приложением
  /// Стрим, передающий [ErrorHandlerModel]
  late final StreamSubscription<dynamic> _errorHandlerSubscription;

  /// Подписка на [errorHandlerState] в репозитории
  Future<void> _subscribe(SubscribeErrorHandlerEvent event,
      Emitter<ErrorHandlerState> emit) async {}

  /// Обработка события показа ошибки
  void _showError(
          ShowErrorHandlerEvent event, Emitter<ErrorHandlerState> emit) =>
      emit(ShowErrorHandlerState(errorHandlerModel: event.errorHandlerModel));

  @override
  Future<void> close() {
    _errorHandlerSubscription.cancel();
    return super.close();
  }
}
