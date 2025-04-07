import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class FilterButtonsWidget extends StatelessWidget {
  const FilterButtonsWidget({
    super.key,
    required this.onTap,
    required this.iconPath,
    required this.iconHeight,
    required this.iconWidth,
    required this.text,
  });

  final VoidCallback onTap;
  final String iconPath;
  final double iconWidth;
  final double iconHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.buttonSecondaryBorder,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.buttonSecondaryBg,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 9.h,
          horizontal: 26.5.w,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: iconWidth,
              height: iconHeight,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
            Gap(5.w),
            Text(
              text,
              style: AppTypography.caption1Regular
                  .copyWith(color: AppColors.textPrimary),
            ),
            Gap(5.w),
            SvgPicture.asset(
              'assets/icons/ic_arrow_down.svg',
              width: 10.5.w,
              height: 6.h,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
