import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';

class OverlayApp {
  OverlayEntry createOverlayPO({
    required BuildContext context,
    required LayerLink layerLink,
    required VoidCallback removeOverlay,
  }) {
    return OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: removeOverlay,
                child: Container(
                  color: AppColors.black800.withOpacity(0.5),
                ),
              ),
            ),
            GestureDetector(
              onTap: removeOverlay,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.uiBgPanels,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 730.h,
                    maxWidth: 345.w,
                  ),
                  height: 730.h,
                  width: 345.w,
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 41.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 24.h,
                          left: 25.w,
                          right: 25.w,
                        ),
                        child: Text(
                          'Пользовательское соглашение',
                          style: AppTypography.h5Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const Divider(
                            color: AppColors.uiBorder,
                          ),
                          Gap(25.h),
                          GestureDetector(
                            onTap: removeOverlay,
                            child: Center(
                              child: Text(
                                'Ок',
                                style: AppTypography.h5Bold
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                            ),
                          ),
                          Gap(25.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  OverlayEntry createOverlaySuspiciousAction({
    required BuildContext context,
    required LayerLink layerLink,
    required VoidCallback removeOverlay,
    required String title,
    required String description,
  }) {
    return OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: removeOverlay,
                child: Container(
                  color: AppColors.black800.withOpacity(0.5),
                ),
              ),
            ),
            GestureDetector(
              onTap: removeOverlay,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.uiBgPanels,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 194.h,
                    maxWidth: 345.w,
                  ),
                  height: 194.h,
                  width: 345.w,
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    // vertical: 41.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.w,
                        ).copyWith(top: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTypography.h5Bold
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                            Gap(16.h),
                            Text(
                              description,
                              style: AppTypography.caption1Regular
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                            Gap(26.h),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const Divider(
                            color: AppColors.uiBorder,
                          ),
                          Gap(14.h),
                          GestureDetector(
                            onTap: removeOverlay,
                            child: Center(
                              child: Text(
                                'Ок',
                                style: AppTypography.h5Bold
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                            ),
                          ),
                          Gap(14.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  OverlayEntry createOverlayDraftProjects({
    required BuildContext context,
    required LayerLink layerLink,
    required VoidCallback removeOverlay,
    required VoidCallback noClick,
    required VoidCallback yesClick,
  }) {
    return OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: removeOverlay,
                child: Container(
                  color: AppColors.black800.withOpacity(0.5),
                ),
              ),
            ),
            GestureDetector(
              onTap: removeOverlay,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.uiBgPanels,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 210.h,
                    maxWidth: 345.w,
                  ),
                  height: 202.h,
                  width: 345.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(24.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Text(
                          'У вас есть несохраненные проекты. Хотите продолжить?',
                          style: AppTypography.h5Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Gap(16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Text(
                          'Похоже вы не завершили создание некоторых проектов, мы сохранили их в “Черновики”. Хотите продолжить создание проектов?',
                          style: AppTypography.caption1Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Gap(26.h),
                      const Divider(
                        color: AppColors.uiBorder,
                        height: 1,
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: noClick,
                            child: Container(
                              width: 172.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Нет',
                                  style: AppTypography.h5Bold.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 1.w,
                            height: 48.h,
                            color: AppColors.uiBorder,
                          ),
                          GestureDetector(
                            onTap: yesClick,
                            child: Container(
                              width: 172.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.r),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Да',
                                  style: AppTypography.h5Bold.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  OverlayEntry createOverlayGenerateEstimate({
    required BuildContext context,
    required LayerLink layerLink,
  }) {
    return OverlayEntry(
      maintainState: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.uiBgPanels,
              borderRadius: BorderRadius.circular(10.r),
            ),
            constraints: BoxConstraints(
              maxHeight: 180.h,
              maxWidth: 345.w,
            ),
            height: 170.h,
            width: 345.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Text(
                    'Формируем смету',
                    style: AppTypography.h5Bold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Gap(16.h),
                const CircularProgressIndicator(
                  backgroundColor: AppColors.uiBorder,
                  color: AppColors.color9298C2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
