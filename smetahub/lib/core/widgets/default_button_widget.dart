import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.buttonWidget,
    this.height,
    this.width,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
  });

  final VoidCallback onTap;
  final String buttonText;
  final Widget? buttonWidget;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.buttonPrimaryBg,
          border: Border.all(
            color: borderColor ?? AppColors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 13.h,
          horizontal: buttonWidget != null ? 0 : 76.w,
        ),
        child: buttonWidget ??
            Center(
              child: Text(
                buttonText,
                style: textStyle ?? AppTypography.headlineRegular,
              ),
            ),
      ),
    );
  }
}
