import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/auth/presentation/bloc/auth_bloc.dart';

class PoOverlayWidget extends StatelessWidget {
  const PoOverlayWidget({
    super.key,
    this.isSignIn = true,
  });

  final bool? isSignIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'Продолжая вы принимаете условия',
            style: AppTypography.caption1Regular
                .copyWith(color: AppColors.textPrimary),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: GestureDetector(
            onTap: () {
              if (isSignIn == true) {
                context.read<AuthBloc>().add(
                      ShowSignInPOOverlayEvent(),
                    );
              } else if (isSignIn == false) {
                context.read<AuthBloc>().add(ShowSignUpPOOverlayEvent());
              }
            },
            child: Text(
              'Пользовательского соглашения',
              style: AppTypography.caption1Medium.copyWith(
                  color: AppColors.textPrimary,
                  decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    );
  }
}
