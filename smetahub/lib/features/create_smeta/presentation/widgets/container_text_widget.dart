import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class ContainerTextWidget extends StatelessWidget {
  const ContainerTextWidget({
    super.key,
    required this.text,
    this.bgColor,
    this.childWidget,
    this.textStyle,
  });

  final String text;
  final Color? bgColor;
  final Widget? childWidget;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.blue700A18,
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 2.h,
      ),
      child: childWidget ??
          Text(
            text,
            style: textStyle ??
                AppTypography.subheadsMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
          ),
    );
  }
}
