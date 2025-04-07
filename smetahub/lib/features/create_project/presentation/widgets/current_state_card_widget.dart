import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class CurrentStateCardWidget extends StatelessWidget {
  const CurrentStateCardWidget({
    super.key,
    this.image,
    this.title,
    this.onTap,
    this.isSelected = false,
  });

  final String? image;
  final String? title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 165.w,
        height: 153.h,
        padding: EdgeInsets.only(
          bottom: 0.h,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  ),
                  child: image != null
                      ? Image.network(
                          image!,
                          width: 165.w,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
                ),
                Gap(8.h),
                Text(
                  title ?? '',
                  style: AppTypography.subheadsRegular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
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
