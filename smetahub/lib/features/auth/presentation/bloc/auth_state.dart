part of 'auth_bloc.dart';

abstract class AuthState {}

class ShowSignInState extends AuthState {
  final bool hidePassword;
  final bool isOpenPOOverlay;
  final bool isSuspiciousAction;
  final bool textfieldError;
  final String? signInErrorText;

  ShowSignInState({
    required this.hidePassword,
    this.isOpenPOOverlay = false,
    this.isSuspiciousAction = false,
    this.textfieldError = false,
    this.signInErrorText,
  });

  ShowSignInState copyWith({
    bool? hidePassword,
    bool? isOpenPOOverlay,
    bool? isSuspiciousAction,
    bool? textfieldError,
    String? signInErrorText,
  }) {
    return ShowSignInState(
      hidePassword: hidePassword ?? this.hidePassword,
      isOpenPOOverlay: isOpenPOOverlay ?? this.isOpenPOOverlay,
      isSuspiciousAction: isSuspiciousAction ?? this.isSuspiciousAction,
      textfieldError: textfieldError ?? this.textfieldError,
      signInErrorText: signInErrorText ?? this.signInErrorText,
    );
  }
}

class ShowResetPasswordState extends AuthState {
  ShowResetPasswordState({
    required this.currentPage,
    // required this.phoneNumber,
    required this.email,
    required this.code,
    this.codeVerified = false,
    required this.newHidePassword,
    required this.newHideSecondPassword,
    this.symbolsCorrect,
    this.lettersCorrect,
    this.numberCorrect,
    this.isSuspiciousAction = false,
  });

  final int currentPage;
  // final String phoneNumber;
  final String email;
  final String code;

  final bool? codeVerified;

  final bool newHidePassword;
  final bool newHideSecondPassword;

  final bool? symbolsCorrect;
  final bool? lettersCorrect;
  final bool? numberCorrect;

  final bool isSuspiciousAction;

  ShowResetPasswordState copyWith({
    int? currentPage,
    // String? phoneNumber,
    String? email,
    String? code,
    bool? codeVerified,
    bool? newHidePassword,
    bool? newHideSecondPassword,
    bool? symbolsCorrect,
    bool? lettersCorrect,
    bool? numberCorrect,
    bool? isSuspiciousAction,
  }) {
    return ShowResetPasswordState(
      currentPage: currentPage ?? this.currentPage,
      // phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      code: code ?? this.code,
      codeVerified: codeVerified ?? this.codeVerified,
      newHidePassword: newHidePassword ?? this.newHidePassword,
      newHideSecondPassword:
          newHideSecondPassword ?? this.newHideSecondPassword,
      symbolsCorrect: symbolsCorrect ?? this.symbolsCorrect,
      lettersCorrect: lettersCorrect ?? this.lettersCorrect,
      numberCorrect: numberCorrect ?? this.numberCorrect,
      isSuspiciousAction: isSuspiciousAction ?? this.isSuspiciousAction,
    );
  }
}

class ShowSignUpState extends AuthState {
  ShowSignUpState({
    // required this.phoneNumber,
    required this.email,
    required this.password,
    required this.code,
    this.codeVerified = false,
    required this.currentPage,
    required this.isOpenPOOverlay,
    required this.hidePassword,
    required this.hideSecondPassword,
    this.symbolsCorrect,
    this.lettersCorrect,
    this.numberCorrect,
    this.isSuspiciousAction = false,
  });

  final String email;
  // final String phoneNumber;
  final String password;
  final String code;

  final bool? codeVerified;

  final int currentPage;
  final bool isOpenPOOverlay;

  final bool hidePassword;
  final bool hideSecondPassword;

  final bool? symbolsCorrect;
  final bool? lettersCorrect;
  final bool? numberCorrect;

  final bool isSuspiciousAction;

  ShowSignUpState copyWith({
    // String? phoneNumber,
    String? email,
    String? password,
    String? code,
    bool? codeVerified,
    int? currentPage,
    bool? isOpenPOOverlay,
    bool? hidePassword,
    bool? hideSecondPassword,
    bool? symbolsCorrect,
    bool? lettersCorrect,
    bool? numberCorrect,
    bool? isSuspiciousAction,
  }) {
    return ShowSignUpState(
      // phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      code: code ?? this.code,
      codeVerified: codeVerified ?? this.codeVerified,
      currentPage: currentPage ?? this.currentPage,
      isOpenPOOverlay: isOpenPOOverlay ?? this.isOpenPOOverlay,
      hidePassword: hidePassword ?? this.hidePassword,
      hideSecondPassword: hideSecondPassword ?? this.hideSecondPassword,
      symbolsCorrect: symbolsCorrect ?? this.symbolsCorrect,
      lettersCorrect: lettersCorrect ?? this.lettersCorrect,
      numberCorrect: numberCorrect ?? this.numberCorrect,
      isSuspiciousAction: isSuspiciousAction ?? this.isSuspiciousAction,
    );
  }
}

class SignInSuccess extends AuthState {}

class SignUpSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}
