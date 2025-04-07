import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class MaterialButtonWidget extends StatelessWidget {
  const MaterialButtonWidget({
    super.key,
    this.text,
    required this.onTap,
    this.isSelected = false,
  });

  final String? text;
  final bool isSelected;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        decoration: isSelected
            ? ShapeDecoration(
                color: AppColors.transparent,
                shape: FancyBorder(
                  shape: const RoundedRectangleBorder(),
                  width: 1,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.gradient1,
                      AppColors.gradient2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  corners: BorderRadius.all(Radius.circular(13.r)),
                ),
              )
            : BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(13.r),
                border: Border.all(
                  color: AppColors.gray100,
                ),
              ),
        child: Row(
          children: [
            Text(
              text ?? '',
              style: AppTypography.subheadsRegular
                  .copyWith(color: AppColors.textPrimary),
            ),
            const Spacer(),
            Container(
              height: 16.h,
              width: 16.w,
              decoration: BoxDecoration(
                color:
                    isSelected ? AppColors.gradient1 : AppColors.uiBackground,
                borderRadius: BorderRadius.circular(45.r),
                border: Border.all(
                  color: AppColors.uiSecondaryBorder,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
