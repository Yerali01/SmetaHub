import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smetahub/repository/app_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AppRepository appRepository,
  })  : _appRepository = appRepository,
        super(
          ShowSignInState(
            hidePassword: true,
            isOpenPOOverlay: false,
          ),
        ) {
    on<ShowSignInPOOverlayEvent>(_showSignInPOOverlay);
    on<ShowSignUpPOOverlayEvent>(_showSignUpPOOverlay);
    on<SignInHidePasswordEvent>(_signInHidePassword);
    on<SignUpHidePasswordEvent>(_signUpHidePassword);
    on<SignUpHideSecondPasswordEvent>(_signUpSecondHidePassword);
    on<GoToSignUpEvent>(_goToSignUpEvent);
    on<GoToResetPasswordEvent>(_goToResetPasswordEvent);
    on<GoToSignInEvent>(_goToSignInEvent);

    on<ResetPasswordHidePasswordEvent>(_resetPasswordHidePassword);
    on<ResetPasswordHideSecondPasswordEvent>(_resetPasswordHideSecondPassword);

    on<SendSMSCodeEvent>(_sendVerificationCode);
    on<VerifySMSCOdeEvent>(_verifyCode);
    on<SignUpUserEvent>(_signUpUser);
    on<SetPasswordEvent>(_setPassword);

    on<SignInUserEvent>(_signInUser);

    on<SignUpRowCodeFilledEvent>(_signUpIsRowCodeFilled);
    on<ResetPasswordRowCodeFilledEvent>(_resetIsRowCodeFilled);
    on<SignUpCheckTwoPasswordsEvent>(_signUpCheckTwoPasswords);
    on<ResetPasswordCheckTwoPasswordsEvent>(_resetPasswordCheckTwoPasswords);

    on<ResetPasswordRequestEvent>(_resetPasswordRequest);
    on<ResetPasswordVerifyCodeEvent>(_resetPasswordVerify);
    on<ResetPasswordConfirmEvent>(_resetPasswordConfirm);

    on<ShowSignInSuspiciousActionOverlayEvent>(
        _showSignInSuspiciousActionOverlay);
    on<ShowSignUpSuspiciousActionOverlayEvent>(
        _showSignUpSuspiciousActionOverlay);
    on<ShowResetPasswordSuspiciousActionOverlayEvent>(
        _showResetPasswordSuspiciousActionOverlay);
  }

  final AppRepository _appRepository;

  Future<void> _showSignInPOOverlay(
    final ShowSignInPOOverlayEvent event,
    final Emitter<AuthState> emit,
  ) async {
    if (state is ShowSignInState) {
      final ShowSignInState state = this.state as ShowSignInState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isOpenPOOverlay: !state.isOpenPOOverlay,
        ),
      );
    }
  }

  Future<void> _showSignInSuspiciousActionOverlay(
    final ShowSignInSuspiciousActionOverlayEvent event,
    final Emitter<AuthState> emit,
  ) async {
    if (state is ShowSignInState) {
      final ShowSignInState state = this.state as ShowSignInState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isSuspiciousAction: !state.isSuspiciousAction,
        ),
      );
    }
  }

  Future<void> _showSignUpSuspiciousActionOverlay(
    final ShowSignUpSuspiciousActionOverlayEvent event,
    final Emitter<AuthState> emit,
  ) async {
    if (state is ShowSignUpState) {
      final ShowSignUpState state = this.state as ShowSignUpState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isSuspiciousAction: !state.isSuspiciousAction,
        ),
      );
    }
  }

  Future<void> _showResetPasswordSuspiciousActionOverlay(
    final ShowResetPasswordSuspiciousActionOverlayEvent event,
    final Emitter<AuthState> emit,
  ) async {
    if (state is ShowResetPasswordState) {
      final ShowResetPasswordState state = this.state as ShowResetPasswordState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isSuspiciousAction: !state.isSuspiciousAction,
        ),
      );
    }
  }

  Future<void> _showSignUpPOOverlay(
    final ShowSignUpPOOverlayEvent event,
    final Emitter<AuthState> emit,
  ) async {
    if (state is ShowSignUpState) {
      final ShowSignUpState state = this.state as ShowSignUpState;

      /// обновляем состояние
      emit(
        state.copyWith(
          isOpenPOOverlay: !state.isOpenPOOverlay,
        ),
      );
    }
  }

  Future<void> _goToResetPasswordEvent(
    final GoToResetPasswordEvent event,
    final Emitter<AuthState> emit,
  ) async {
    /// обновляем состояние
    emit(
      ShowResetPasswordState(
        // phoneNumber: '',
        email: '',
        code: '',
        currentPage: event.currentPage ?? 0,
        newHidePassword: false,
        newHideSecondPassword: false,
      ),
    );
  }

  Future<void> _goToSignUpEvent(
    final GoToSignUpEvent event,
    final Emitter<AuthState> emit,
  ) async {
    /// обновляем состояние
    emit(
      ShowSignUpState(
        // phoneNumber: '',
        email: '',
        password: '',
        code: '',
        currentPage: event.currentPage ?? 0,
        isOpenPOOverlay: false,
        hidePassword: false,
        hideSecondPassword: false,
      ),
    );
  }

  Future<void> _goToSignInEvent(
    final GoToSignInEvent event,
    final Emitter<AuthState> emit,
  ) async {
    /// обновляем состояние
    emit(
      ShowSignInState(
        hidePassword: false,
      ),
    );
  }

  void _signInHidePassword(
    final SignInHidePasswordEvent event,
    final Emitter<AuthState> emit,
  ) {
    if (state is ShowSignInState) {
      final ShowSignInState state = this.state as ShowSignInState;

      emit(
        state.copyWith(
          hidePassword: !state.hidePassword,
        ),
      );
    }
  }

  void _signUpHidePassword(
    final SignUpHidePasswordEvent event,
    final Emitter<AuthState> emit,
  ) {
    if (state is ShowSignUpState) {
      final ShowSignUpState state = this.state as ShowSignUpState;

      emit(
        state.copyWith(
          hidePassword: !state.hidePassword,
        ),
      );
    }
  }

  void _resetPasswordHidePassword(
    final ResetPasswordHidePasswordEvent event,
    final Emitter<AuthState> emit,
  ) {
    if (state is ShowResetPasswordState) {
      final ShowResetPasswordState state = this.state as ShowResetPasswordState;

      emit(
        state.copyWith(
          newHidePassword: !state.newHidePassword,
        ),
      );
    }
  }

  void _resetPasswordHideSecondPassword(
    final ResetPasswordHideSecondPasswordEvent event,
    final Emitter<AuthState> emit,
  ) {
    if (state is ShowResetPasswordState) {
      final ShowResetPasswordState state = this.state as ShowResetPasswordState;

      emit(
        state.copyWith(
          newHideSecondPassword: !state.newHideSecondPassword,
        ),
      );
    }
  }

  void _signUpSecondHidePassword(
    final SignUpHideSecondPasswordEvent event,
    final Emitter<AuthState> emit,
  ) {
    if (state is ShowSignUpState) {
      final ShowSignUpState state = this.state as ShowSignUpState;

      emit(
        state.copyWith(
          hideSecondPassword: !state.hideSecondPassword,
        ),
      );
    }
  }

  Future<void> _sendVerificationCode(
    final SendSMSCodeEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      // if (state is ShowSignUpState) {
      // final ShowSignUpState state = this.state as ShowSignUpState;
      await _appRepository.sendVerificationCode(
        // event.phoneNumber,
        email: event.email,
      );
      // emit(
      // state.copyWith(
      // phoneNumber: event.phoneNumber,
      // currentPage: state.currentPage + 1,
      // ),
      // );
      // }
    } on Exception {
      log('Ошибка!!! _sendVerificationCode');
    }
  }

  Future<void> _verifyCode(
    final VerifySMSCOdeEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      if (state is ShowSignUpState) {
        final ShowSignUpState state = this.state as ShowSignUpState;
        final res = await _appRepository.verifySignUpPhone(
          // phoneNumber: state.phoneNumber,
          email: state.email,
          code: event.code,
        );

        if (res.data["access_token"] != null) {
          _appRepository.accessToken.add(res.data["access_token"]);
          _appRepository.refreshToken.add(res.data["refresh_token"]);

          emit(
            state.copyWith(
              codeVerified: true,
              // phoneNumber: state.phoneNumber,
              email: state.email,
              code: event.code,
              currentPage: state.currentPage + 1,
            ),
          );
        }
        log('res ${res.data}');
      }
    } on DioException catch (e) {
      log('Ошибка!!! _verifyCode => ${e.response?.data['detail']}');

      if (e.response?.data['detail'].toString() ==
          'Слишком много неудачных попыток. Вы заблокированы на 30 минут') {
        final ShowSignUpState state = this.state as ShowSignUpState;
        emit(
          state.copyWith(
            isSuspiciousAction: true,
          ),
        );
      }
    }
  }

  Future<void> _signUpUser(
    final SignUpUserEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      if (state is ShowSignUpState) {
        final ShowSignUpState state = this.state as ShowSignUpState;
        await _appRepository.userSignUp(
            // phoneNumber: event.phoneNumber,
            email: event.email);
        emit(
          state.copyWith(
            currentPage: state.currentPage + 1,
            // phoneNumber: event.phoneNumber,
            email: event.email,
          ),
        );
      }
    } on Exception {
      log('Ошибка!!! signUp User');
    }
  }

  Future<void> _signInUser(
    final SignInUserEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      final res = await _appRepository.userSignIn(
        password: event.password,
        // phoneNumber: event.phoneNumber,
        email: event.email,
      );

      ShowSignInState state = this.state as ShowSignInState;
      log('res $res');
      if (res["access_token"] != null) {
        _appRepository.accessToken.add(res["access_token"]);
        _appRepository.refreshToken.add(res["refresh_token"]);
        emit(
          SignInSuccess(),
        );
      } else {
        emit(
          state.copyWith(
            textfieldError: true,
            signInErrorText: res['detail'],
          ),
        );
      }
    } on DioException catch (e) {
      log('Ошибка!!! _signInUser => $e');
      ShowSignInState state = this.state as ShowSignInState;
      emit(
        state.copyWith(
          textfieldError: true,
          signInErrorText: e.response?.data['detail'] ?? '',
          isSuspiciousAction: !state.isSuspiciousAction,
        ),
      );
    }
  }

  Future<void> _setPassword(
    SetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    // меняю состояние чтобы кнопка продолжить могла менять цвет и была активна/неактивна
    // final ShowSignUpState state = this.state as ShowSignUpState;
    final res = await _appRepository.setPassword(password: event.password);
    if (res["success"] == true) {
      emit(
        SignUpSuccess(),
      );
    }
  }

  Future<void> _signUpIsRowCodeFilled(
    SignUpRowCodeFilledEvent event,
    Emitter<AuthState> emit,
  ) async {
    // меняю состояние чтобы кнопка продолжить могла менять цвет и была активна/неактивна
    final ShowSignUpState state = this.state as ShowSignUpState;
    emit(
      state.copyWith(
        code: event.code,
      ),
    );
  }

  Future<void> _resetIsRowCodeFilled(
    ResetPasswordRowCodeFilledEvent event,
    Emitter<AuthState> emit,
  ) async {
    // меняю состояние чтобы кнопка продолжить могла менять цвет и была активна/неактивна
    final ShowResetPasswordState state = this.state as ShowResetPasswordState;
    emit(
      state.copyWith(
        code: event.code,
      ),
    );
  }

  Future<void> _signUpCheckTwoPasswords(
    SignUpCheckTwoPasswordsEvent event,
    Emitter<AuthState> emit,
  ) async {
    final ShowSignUpState state = this.state as ShowSignUpState;

    bool symbols = false;
    bool numbers = false;
    bool letters = false;

    if (event.password.length < 8) {
      symbols = false;
    } else {
      symbols = true;
    }
    if (!containsNumbers(event.password)) {
      numbers = false;
    } else {
      numbers = true;
    }

    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

    if (regEx.hasMatch(event.password)) {
      letters = true;
    } else {
      letters = false;
    }

    emit(
      state.copyWith(
        numberCorrect: numbers,
        lettersCorrect: letters,
        symbolsCorrect: symbols,
      ),
    );
  }

  Future<void> _resetPasswordCheckTwoPasswords(
    ResetPasswordCheckTwoPasswordsEvent event,
    Emitter<AuthState> emit,
  ) async {
    final ShowResetPasswordState state = this.state as ShowResetPasswordState;

    bool symbols = false;
    bool numbers = false;
    bool letters = false;

    if (event.newPassword.length < 8) {
      symbols = false;
    } else {
      symbols = true;
    }
    if (!containsNumbers(event.newPassword)) {
      numbers = false;
    } else {
      numbers = true;
    }

    RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

    if (regEx.hasMatch(event.newPassword)) {
      letters = true;
    } else {
      letters = false;
    }

    emit(
      state.copyWith(
        numberCorrect: numbers,
        lettersCorrect: letters,
        symbolsCorrect: symbols,
      ),
    );
  }

  bool containsNumbers(String text) {
    final RegExp numberRegExp = RegExp(r'\d');
    return numberRegExp.hasMatch(text);
  }

  Future<void> _resetPasswordRequest(
    final ResetPasswordRequestEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      if (state is ShowResetPasswordState) {
        final ShowResetPasswordState state =
            this.state as ShowResetPasswordState;
        final res = await _appRepository.resetPasswordRequest(
          // phoneNumber: event.phoneNumber,
          email: event.email,
        );
        if (res["success"] == true) {
          emit(
            state.copyWith(
              // phoneNumber: event.phoneNumber,
              email: event.email,
              currentPage: state.currentPage + 1,
            ),
          );
        }
      }
    } on Exception {
      log('Ошибка!!! _resetPasswordRequest');
    }
  }

  Future<void> _resetPasswordVerify(
    final ResetPasswordVerifyCodeEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      if (state is ShowResetPasswordState) {
        final ShowResetPasswordState state =
            this.state as ShowResetPasswordState;
        final res = await _appRepository.verifyResetCode(
          code: event.code,
          // phoneNumber: state.phoneNumber,
          email: state.email,
        );

        if (res.data["access_token"] != null) {
          _appRepository.accessToken.add(res.data["access_token"]);
          _appRepository.refreshToken.add(res.data["refresh_token"]);

          emit(
            state.copyWith(
              codeVerified: true,
              // phoneNumber: state.phoneNumber,
              email: state.email,
              code: event.code,
              currentPage: state.currentPage + 1,
            ),
          );
        }
      }
    } on DioException catch (e) {
      // log('Ошибка!!! _resetPasswordVerify');
      if (e.response?.data['detail'].toString() ==
          'Неверный код, осталось попыток: 0') {
        final ShowResetPasswordState state =
            this.state as ShowResetPasswordState;
        emit(
          state.copyWith(
            isSuspiciousAction: true,
          ),
        );
      }
    }
  }

  Future<void> _resetPasswordConfirm(
    final ResetPasswordConfirmEvent event,
    final Emitter<AuthState> emit,
  ) async {
    try {
      if (state is ShowResetPasswordState) {
        if (_appRepository.accessToken.valueOrNull != null) {
          final res = await _appRepository.resetPasswordConfirm(
            newPassword: event.newPassword,
            accessToken: _appRepository.accessToken.value,
          );
          if (res["success"] == true) {
            emit(
              ResetPasswordSuccess(),
            );
          }
        }
      }
    } on Exception {
      log('Ошибка!!! _resetPasswordRequest');
    }
  }
}
