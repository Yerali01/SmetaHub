part of 'error_handler_bloc.dart';

/// Абстрактный класс для определения состояния компонента Бизнес-Логики
@immutable
abstract class ErrorHandlerState {
  const ErrorHandlerState();
}

/// Состояние инициализации
class ErrorHandlerInitialState extends ErrorHandlerState {}

/// Состояние показа ошибки
class ShowErrorHandlerState extends ErrorHandlerState {

  const ShowErrorHandlerState({required this.errorHandlerModel});
  final ErrorHandlerModel errorHandlerModel;
}
