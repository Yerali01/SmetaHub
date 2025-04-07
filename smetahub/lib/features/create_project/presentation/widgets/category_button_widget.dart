import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class CategoryButtonWidget extends StatelessWidget {
  const CategoryButtonWidget({
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
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(
            color: isSelected ? AppColors.gradient1 : AppColors.gray100,
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
