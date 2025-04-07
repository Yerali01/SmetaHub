part of 'auth_bloc.dart';

abstract class AuthEvent {}

class ShowSignInPOOverlayEvent extends AuthEvent {}

class ShowSignInSuspiciousActionOverlayEvent extends AuthEvent {}

class ShowSignUpSuspiciousActionOverlayEvent extends AuthEvent {}

class ShowResetPasswordSuspiciousActionOverlayEvent extends AuthEvent {}

class ShowSignUpPOOverlayEvent extends AuthEvent {}

class SignInHidePasswordEvent extends AuthEvent {}

class SignUpHidePasswordEvent extends AuthEvent {}

class SignUpHideSecondPasswordEvent extends AuthEvent {}

class ResetPasswordHidePasswordEvent extends AuthEvent {}

class ResetPasswordHideSecondPasswordEvent extends AuthEvent {}

class GoToSignInEvent extends AuthEvent {}

class GoToSignUpEvent extends AuthEvent {
  final int? currentPage;

  GoToSignUpEvent({this.currentPage});
}

class GoToResetPasswordEvent extends AuthEvent {
  final int? currentPage;

  GoToResetPasswordEvent({this.currentPage});
}

class SendSMSCodeEvent extends AuthEvent {
  final String phoneNumber;

  SendSMSCodeEvent({required this.phoneNumber});
}

class VerifySMSCOdeEvent extends AuthEvent {
  final String code;

  VerifySMSCOdeEvent({required this.code});
}

class SignUpUserEvent extends AuthEvent {
  final String phoneNumber;

  SignUpUserEvent({
    required this.phoneNumber,
  });
}

class SetPasswordEvent extends AuthEvent {
  final String password;

  SetPasswordEvent({
    required this.password,
  });
}

class SignInUserEvent extends AuthEvent {
  final String phoneNumber;
  final String password;

  SignInUserEvent({
    required this.phoneNumber,
    required this.password,
  });
}

class SignUpRowCodeFilledEvent extends AuthEvent {
  SignUpRowCodeFilledEvent({
    required this.isActive,
    required this.code,
  });

  // активность кнопки
  final bool isActive;
  // код который пришел на номер
  final String code;
}

class ResetPasswordRowCodeFilledEvent extends AuthEvent {
  ResetPasswordRowCodeFilledEvent({
    required this.isActive,
    required this.code,
  });

  // активность кнопки
  final bool isActive;
  // код который пришел на номер
  final String code;
}

class SignUpCheckTwoPasswordsEvent extends AuthEvent {
  SignUpCheckTwoPasswordsEvent({
    required this.password,
    required this.secondPassword,
  });

  // активность кнопки
  final String password;
  // код который пришел на номер
  final String secondPassword;
}

class ResetPasswordCheckTwoPasswordsEvent extends AuthEvent {
  ResetPasswordCheckTwoPasswordsEvent({
    required this.newPassword,
    required this.newSecondPassword,
  });

  // активность кнопки
  final String newPassword;
  // код который пришел на номер
  final String newSecondPassword;
}

class ResetPasswordRequestEvent extends AuthEvent {
  final String phoneNumber;

  ResetPasswordRequestEvent({required this.phoneNumber});
}

class ResetPasswordVerifyCodeEvent extends AuthEvent {
  final String code;

  ResetPasswordVerifyCodeEvent({required this.code});
}

class ResetPasswordConfirmEvent extends AuthEvent {
  final String newPassword;

  ResetPasswordConfirmEvent({
    required this.newPassword,
  });
}
