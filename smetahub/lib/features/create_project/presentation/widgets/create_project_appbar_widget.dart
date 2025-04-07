import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/auth/presentation/widgets/linear_progress_bar_widget.dart';

class CreateProjectAppbarWidget extends StatelessWidget {
  const CreateProjectAppbarWidget({
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
                context.router.navigate(const HomeWrapperRoute());
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_arrow_left.svg',
                    width: 6.w,
                    height: 11.h,
                    colorFilter: const ColorFilter.mode(
                      Color.fromRGBO(7, 12, 43, 1),
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
              'Создать проект',
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
        LinearProgressBarWidget(
          percentage: percentage == 0 ? 0.02 : percentage,
        ),
      ],
    );
  }
}
