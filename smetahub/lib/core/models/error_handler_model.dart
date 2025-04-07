// Project imports:

/// Модель ошибки
class ErrorHandlerModel {

  factory ErrorHandlerModel.fromNetwork({required Map<String, String>? data}) {
    try{
      return ErrorHandlerModel(
        errorTitle: data?['message'],
      );
    }catch(e){
      return ErrorHandlerModel(
        errorTitle: '${data?? '404 Not Found'}',
      );
    }
  }

  ErrorHandlerModel({
    this.errorTitle,
    this.errorDescription,
    this.errorType,
  });
  /// Заголовок ошибки
  final String? errorTitle;
  /// Описание ошибки
  final String? errorDescription;
  /// Тип ошибки
  final ErrorHandlerTypeEnum? errorType;
}

/// Типы состояний ошибок
enum ErrorHandlerTypeEnum {
  /// Ошибка произошла в коде приложения
  local,
  /// Ошибка произошла на сервере
  network,
  /// Предупреждение, отображение с желтой иконкой
  warning,
  /// Уведомление об успешной операции, отображение с зеленой иконкой
  good,
}