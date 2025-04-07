import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({
    super.key,
    this.imageUrl,
    this.title,
    this.onTap,
    this.isSelected = false,
  });

  final String? imageUrl;
  final String? title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        height: 165.h,
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(
            color:
                isSelected ? AppColors.gradient1 : AppColors.uiSecondaryBorder,
            width: 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        height: 80.h,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink(),
                Gap(10.h),
                Text(
                  title ?? '',
                  style: AppTypography.subheadsRegular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Positioned(
              top: 10.h,
              right: 10.w,
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
