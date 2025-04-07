part of 'error_handler_bloc.dart';

/// Абстрактный класс Событий ошибок приложения (для компонента Бизнес-Логики)
@immutable
abstract class ErrorHandlerEvent {
  const ErrorHandlerEvent();
}

/// Событие подписки
class SubscribeErrorHandlerEvent extends ErrorHandlerEvent {}

/// Событие показа ошибки
/// Принимает [ErrorHandlerModel]
class ShowErrorHandlerEvent extends ErrorHandlerEvent {
  const ShowErrorHandlerEvent({required this.errorHandlerModel});
  final ErrorHandlerModel errorHandlerModel;
}
