import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/utils/overlay_app.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';
import 'package:smetahub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smetahub/features/auth/presentation/widgets/reset_password_appbar.dart';
import 'package:smetahub/features/auth/presentation/widgets/row_code_phone.dart';
import 'package:smetahub/features/auth/presentation/widgets/sign_up_appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordSecondController =
      TextEditingController();

  bool isPasswordMatch = false;

  OverlayEntry? _overlaySuspiciousEntry;
  final LayerLink _layerLinkSuspicious = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.uiBgPanels,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is ResetPasswordSuccess) {
            context.read<AuthBloc>().add(
                  GoToSignInEvent(),
                );
          }
          if (state is ShowResetPasswordState) {
            if (state.isSuspiciousAction == true) {
              _overlaySuspiciousEntry =
                  OverlayApp().createOverlaySuspiciousAction(
                context: context,
                layerLink: _layerLinkSuspicious,
                removeOverlay: () {
                  context.read<AuthBloc>().add(
                        ShowResetPasswordSuspiciousActionOverlayEvent(),
                      );
                  _overlaySuspiciousEntry!.remove();
                },
                title: "Слишком много запросов SMS",
                description:
                    "Вы запрашивали отправку SMS-кода слишком часто. Пожалуйста, подождите 30 минут перед следующей попыткой",
              );
              Overlay.of(context).insert(_overlaySuspiciousEntry!);
            }
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is ShowResetPasswordState) {
            if (state.currentPage == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ResetPasswordAppbar(percentage: 0),
                    Gap(22.h),
                    Text(
                      'Введите свой номер телефона',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    Gap(24.h),
                    DefaultTextFormField(
                      isPhone: true,
                      hintText: 'Номер телефона',
                      controller: phoneController,
                    ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (phoneController.text.length == 16) {
                          context.read<AuthBloc>().add(
                                ResetPasswordRequestEvent(
                                  phoneNumber:
                                      phoneController.text.replaceAll(" ", ''),
                                ),
                              );
                        }
                      },
                      backgroundColor: AppColors.buttonPrimaryBg,
                      buttonText: 'Далее',
                      textStyle: AppTypography.headlineRegular
                          .copyWith(color: AppColors.buttonPrimaryText),
                    ),
                  ],
                ),
              );
            } else if (state.currentPage == 1) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ResetPasswordAppbar(percentage: 0.5),
                    Gap(22.h),
                    Text(
                      'Введите SMS-код',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    Gap(12.h),
                    RichText(
                      text: TextSpan(
                        text:
                            'Введите код отправленный\nна ваш номер телефона ',
                        style: AppTypography.bodyRegular.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: phoneController.text,
                            style: AppTypography.bodyMedium
                                .copyWith(color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(24.h),
                    SizedBox(
                      width: 222.w,
                      child: const RowCodePhone(
                        isResetPassword: true,
                      ),
                    ),
                    Gap(22.h),
                    Text(
                      'Если вы не получили SMS-код:',
                      style: AppTypography.bodyRegular
                          .copyWith(color: AppColors.gray300),
                    ),
                    Gap(12.h),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              SendSMSCodeEvent(phoneNumber: state.phoneNumber),
                            );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                          horizontal: 15.w,
                        ),
                        height: 32.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.buttonSecondaryBg,
                          border: Border.all(
                            color: AppColors.buttonSecondaryBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Отправить повторно',
                            style: AppTypography.bodyRegular
                                .copyWith(color: AppColors.textPrimary),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              ResetPasswordVerifyCodeEvent(
                                code: state.code,
                              ),
                            );
                      },
                      backgroundColor: AppColors.buttonPrimaryBg,
                      buttonText: 'Далее',
                      textStyle: AppTypography.headlineRegular
                          .copyWith(color: AppColors.buttonPrimaryText),
                    ),
                  ],
                ),
              );
            } else if (state.currentPage == 2) {
              Color symbolColor = AppColors.gray300;

              if (state.symbolsCorrect == true) {
                symbolColor = AppColors.green500;
              } else if (state.symbolsCorrect == false) {
                symbolColor = AppColors.red700;
              } else {
                symbolColor = AppColors.gray300;
              }

              Color letterColor = AppColors.gray300;

              if (state.lettersCorrect == true) {
                letterColor = AppColors.green500;
              } else if (state.symbolsCorrect == false) {
                letterColor = AppColors.red700;
              } else {
                letterColor = AppColors.gray300;
              }

              Color numberColor = AppColors.gray300;

              if (state.numberCorrect == true) {
                numberColor = AppColors.green500;
              } else if (state.symbolsCorrect == false) {
                numberColor = AppColors.red700;
              } else {
                numberColor = AppColors.gray300;
              }

              String symbolIcon = 'assets/icons/ic_dot.svg';
              if (state.symbolsCorrect == true) {
                symbolIcon = 'assets/icons/ic_tick.svg';
              } else if (state.symbolsCorrect == false) {
                symbolIcon = 'assets/icons/ic_close.svg';
              } else {
                symbolIcon = 'assets/icons/ic_dot.svg';
              }

              String letterIcon = 'assets/icons/ic_dot.svg';
              if (state.lettersCorrect == true) {
                letterIcon = 'assets/icons/ic_tick.svg';
              } else if (state.lettersCorrect == false) {
                letterIcon = 'assets/icons/ic_close.svg';
              } else {
                letterIcon = 'assets/icons/ic_dot.svg';
              }

              String numberIcon = 'assets/icons/ic_dot.svg';
              if (state.numberCorrect == true) {
                numberIcon = 'assets/icons/ic_tick.svg';
              } else if (state.numberCorrect == false) {
                numberIcon = 'assets/icons/ic_close.svg';
              } else {
                numberIcon = 'assets/icons/ic_dot.svg';
              }

              context.read<AuthBloc>().add(
                    ResetPasswordCheckTwoPasswordsEvent(
                      newPassword: newPasswordController.text,
                      newSecondPassword: newPasswordSecondController.text,
                    ),
                  );

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SignUpAppbar(percentage: 0.9),
                    Gap(22.h),
                    Text(
                      'Придумайте новый пароль',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    Gap(12.h),
                    DefaultTextFormField(
                      hintText: 'Придумайте новый пароль',
                      isPassword: true,
                      controller: newPasswordController,
                      hidePassword: state.newHidePassword,
                      suffixOnTap: () {
                        context.read<AuthBloc>().add(
                              ResetPasswordHidePasswordEvent(),
                            );
                      },
                      isError: isPasswordMatch == false,
                    ),
                    Gap(12.h),
                    DefaultTextFormField(
                      hintText: 'Повторите новый пароль',
                      isPassword: true,
                      controller: newPasswordSecondController,
                      hidePassword: state.newHideSecondPassword,
                      suffixOnTap: () {
                        context.read<AuthBloc>().add(
                              ResetPasswordHideSecondPasswordEvent(),
                            );
                      },
                      onChanged: (String value) {
                        if (value == newPasswordController.text) {
                          setState(() {
                            isPasswordMatch = true;
                          });
                        } else {
                          setState(() {
                            isPasswordMatch = false;
                          });
                        }
                      },
                    ),
                    if (isPasswordMatch == false) Gap(8.h),
                    if (isPasswordMatch == false)
                      Row(
                        children: [
                          Gap(16.w),
                          Text(
                            'Пароли не совпадают',
                            style: AppTypography.caption1Regular
                                .copyWith(color: AppColors.red700),
                          ),
                        ],
                      ),
                    Gap(12.h),
                    Row(
                      children: [
                        Text(
                          'Пароль должен содержать:',
                          style: AppTypography.caption1Regular
                              .copyWith(color: AppColors.gray300),
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          symbolIcon,
                          width: 6.w,
                          height: 6.h,
                          colorFilter: ColorFilter.mode(
                            symbolColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(7.w),
                        Text(
                          'Не менее 8 символов',
                          style: AppTypography.caption1Regular
                              .copyWith(color: symbolColor),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          letterIcon,
                          width: 6.w,
                          height: 6.h,
                          colorFilter: ColorFilter.mode(
                            letterColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(7.w),
                        Text(
                          'Прописные и строчные буквы (А, а...)',
                          style: AppTypography.caption1Regular
                              .copyWith(color: letterColor),
                        ),
                      ],
                    ),
                    Gap(2.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          numberIcon,
                          width: 6.w,
                          height: 6.h,
                          colorFilter: ColorFilter.mode(
                            numberColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        Gap(7.w),
                        Text(
                          'Хотя бы одну цифру (1 , 2, 3...)',
                          style: AppTypography.caption1Regular
                              .copyWith(color: numberColor),
                        ),
                      ],
                    ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (state.symbolsCorrect == true &&
                            state.lettersCorrect == true &&
                            state.numberCorrect == true &&
                            newPasswordController.text ==
                                newPasswordSecondController.text) {
                          context.read<AuthBloc>().add(
                                ResetPasswordConfirmEvent(
                                  newPassword: newPasswordController.text,
                                ),
                              );
                        }
                      },
                      backgroundColor: AppColors.buttonPrimaryBg,
                      buttonText: 'Завершить',
                      textStyle: AppTypography.headlineRegular
                          .copyWith(color: AppColors.buttonPrimaryText),
                    ),
                  ],
                ),
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
