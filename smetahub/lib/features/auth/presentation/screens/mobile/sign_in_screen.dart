import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/utils/overlay_app.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';
import 'package:smetahub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smetahub/features/auth/presentation/screens/mobile/reset_password_screen.dart';
import 'package:smetahub/features/auth/presentation/screens/mobile/sign_up_screen.dart';
import 'package:smetahub/features/auth/presentation/widgets/po_overlay_widget.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OverlayEntry? _overlayEntry;
    final LayerLink _layerLink = LayerLink();

    OverlayEntry? _overlaySuspiciousEntry;
    final LayerLink _layerLinkSuspicious = LayerLink();

    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is ShowSignInState) {
            if (state.isOpenPOOverlay) {
              _overlayEntry = OverlayApp().createOverlayPO(
                context: context,
                layerLink: _layerLink,
                removeOverlay: () {
                  context.read<AuthBloc>().add(
                        ShowSignInPOOverlayEvent(),
                      );
                  _overlayEntry!.remove();
                },
              );
              Overlay.of(context).insert(_overlayEntry!);
            }
            if (state.isSuspiciousAction) {
              _overlaySuspiciousEntry =
                  OverlayApp().createOverlaySuspiciousAction(
                context: context,
                layerLink: _layerLinkSuspicious,
                removeOverlay: () {
                  context.read<AuthBloc>().add(
                        ShowSignInSuspiciousActionOverlayEvent(),
                      );
                  _overlaySuspiciousEntry!.remove();
                },
                title: "Подозрительная активность",
                description: '${state.signInErrorText}',
              );
              Overlay.of(context).insert(_overlaySuspiciousEntry!);
            }
          }
          if (state is SignInSuccess) {
            context.router.replace(
              const HomeWrapperRoute(),
            );
          }
        },
        builder: (BuildContext context, AuthState state) {
          if (state is ShowSignInState) {
            return Container(
              padding: EdgeInsets.only(
                top: 65.h,
                bottom: 33.h,
                right: 15.w,
                left: 15.w,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.color8C50C3,
                    AppColors.colorD6CEED,
                    AppColors.colorE9EAF9,
                  ],
                  stops: [
                    0,
                    0.25,
                    0.495,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_app_icon.svg',
                    height: 100.h,
                    width: 100.w,
                  ),
                  Gap(14.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Добро пожаловать в ',
                      style: AppTypography.caption1Regular
                          .copyWith(color: AppColors.textPrimary),
                      children: [
                        TextSpan(
                          text: 'SmetaHub',
                          style: AppTypography.caption1Medium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(42.h),
                  DefaultTextFormField(
                    isPhone: true,
                    controller: phoneController,
                    hintText: 'Номер телефона',
                    isError: state.textfieldError,
                  ),
                  Gap(12.h),
                  DefaultTextFormField(
                    isPassword: true,
                    hidePassword: state.hidePassword,
                    controller: passwordController,
                    hintText: 'Пароль',
                    suffixOnTap: () {
                      context.read<AuthBloc>().add(
                            SignInHidePasswordEvent(),
                          );
                    },
                    isError: state.textfieldError,
                  ),
                  if (state.textfieldError) Gap(12.h),
                  if (state.textfieldError)
                    Row(
                      children: [
                        Gap(16.w),
                        Text(
                          'Неверный пароль или номер телефона',
                          style: AppTypography.caption1Regular
                              .copyWith(color: AppColors.red700),
                        ),
                      ],
                    ),
                  Gap(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(
                                GoToResetPasswordEvent(),
                              );
                        },
                        child: Text(
                          'Забыли пароль?',
                          style: AppTypography.bodyRegular.copyWith(
                            color: AppColors.textPrimary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(18.h),
                  DefaultButtonWidget(
                    onTap: () {
                      context.read<AuthBloc>().add(
                            SignInUserEvent(
                              phoneNumber:
                                  phoneController.text.replaceAll(" ", ''),
                              password: passwordController.text,
                            ),
                          );
                    },
                    backgroundColor: AppColors.buttonPrimaryBg,
                    buttonText: 'Войти',
                    textStyle: AppTypography.headlineRegular
                        .copyWith(color: AppColors.buttonPrimaryText),
                  ),
                  Gap(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Нет аккаунта? ',
                        style: AppTypography.sfPDW40015
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(GoToSignUpEvent());
                        },
                        child: Text(
                          'Регистрация',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.color9012FF,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const PoOverlayWidget(),
                ],
              ),
            );
          } else if (state is ShowSignUpState) {
            return const SignUpScreen();
          } else if (state is ShowResetPasswordState) {
            return const ResetPasswordScreen();
          } else if (state is SignInSuccess) {
            context.router.replace(
              const HomeWrapperRoute(),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
