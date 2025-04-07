import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smetahub/features/auth/presentation/widgets/linear_progress_bar_widget.dart';

class ResetPasswordAppbar extends StatelessWidget {
  const ResetPasswordAppbar({
    super.key,
    required this.percentage,
  });

  /// format: 0.12
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (percentage.toInt() == 0) {
                  context.read<AuthBloc>().add(
                        GoToSignInEvent(),
                      );
                }
                if (percentage.toInt() == 0.5) {
                  context.read<AuthBloc>().add(GoToSignUpEvent(currentPage: 0));
                }
                if (percentage.toInt() == 0.9) {
                  context.read<AuthBloc>().add(GoToSignUpEvent(currentPage: 1));
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_arrow_left.svg',
                    width: 6.w,
                    height: 11.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  Gap(5.w),
                  Text(
                    'Назад',
                    style: AppTypography.caption1Regular
                        .copyWith(color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
            Text(
              'Восстановление',
              style: AppTypography.headlineRegular
                  .copyWith(color: AppColors.textPrimary),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: AppTypography.caption1Regular
                  .copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        Gap(15.h),
        LinearProgressBarWidget(percentage: percentage),
      ],
    );
  }
}
