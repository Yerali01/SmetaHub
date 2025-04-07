import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smetahub/core/utils/colors.dart';

class DefaultIconButtonWidget extends StatelessWidget {
  const DefaultIconButtonWidget({
    super.key,
    required this.icon,
    required this.iconWidth,
    required this.iconHeight,
  });

  final String icon;
  final double iconWidth;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.h,
      decoration: BoxDecoration(
        color: AppColors.gray300A18.withOpacity(0.18),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: iconWidth,
          height: iconHeight,
          colorFilter: const ColorFilter.mode(
            AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
