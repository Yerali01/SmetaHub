import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/features/create_project/presentation/widgets/bottom_sheet_widget.dart';

class BottomSheetUtils {
  void showCreateProjectInfoSheet({
    required BuildContext context,
    required String title,
    required double height,
    required List<List<String>> mainInformation,
    required VoidCallback removeOverlay,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(38.r)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          //  onTap: removeOverlay,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: double.infinity,
            ),
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.uiBgPanels,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(38.r),
                topRight: Radius.circular(38.r),
              ),
            ),
            child: CreateProjectBottomSheetWidget(
              height: height,
              mainInformation: mainInformation,
              title: title,
              onTap: removeOverlay,
            ),
          ),
        );
      },
    );
  }

  void showCreateProjectFileSheet({
    required BuildContext context,
    required VoidCallback removeOverlay,
    required VoidCallback onTapImage,
    required VoidCallback onTapFile,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(38.r)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          //  onTap: removeOverlay,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: double.infinity,
            ),
            height: 314.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.uiBgPanels,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(38.r),
                topRight: Radius.circular(38.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  height: 4.h,
                  width: 82.w,
                  decoration: BoxDecoration(
                    color: AppColors.uiSecondaryBorder,
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                ),
                Gap(12.h),
                Text(
                  'Добавить файл',
                  style: AppTypography.h5Bold
                      .copyWith(color: AppColors.textPrimary),
                ),
                Gap(36.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      DefaultButtonWidget(
                        onTap: onTapImage,
                        buttonText: '',
                        buttonWidget: Row(
                          children: [
                            Gap(19.w),
                            SvgPicture.asset(
                              'assets/icons/ic_picture.svg',
                              width: 18.w,
                              height: 18.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap(10.w),
                            Text(
                              'Выбрать из галереи',
                              style: AppTypography.subheadsMedium
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/icons/ic_arrow_right.svg',
                              width: 9.w,
                              height: 16.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap(15.w),
                          ],
                        ),
                        backgroundColor: AppColors.transparent,
                        borderColor: AppColors.uiSecondaryBorder,
                        textStyle: AppTypography.headlineRegular
                            .copyWith(color: AppColors.buttonPrimaryText),
                      ),
                      Gap(16.h),
                      DefaultButtonWidget(
                        onTap: onTapFile,
                        buttonText: '',
                        buttonWidget: Row(
                          children: [
                            Gap(21.w),
                            SvgPicture.asset(
                              'assets/icons/ic_document.svg',
                              width: 14.w,
                              height: 18.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap(10.w),
                            Text(
                              'Выбрать из файлов',
                              style: AppTypography.subheadsMedium
                                  .copyWith(color: AppColors.textPrimary),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/icons/ic_arrow_right.svg',
                              width: 9.w,
                              height: 16.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            Gap(15.w),
                          ],
                        ),
                        backgroundColor: AppColors.transparent,
                        borderColor: AppColors.uiSecondaryBorder,
                        textStyle: AppTypography.headlineRegular
                            .copyWith(color: AppColors.buttonPrimaryText),
                      ),
                      Gap(36.h),
                      DefaultButtonWidget(
                        onTap: removeOverlay,
                        buttonText: 'Отмена',
                        backgroundColor: AppColors.transparent,
                        borderColor: AppColors.uiSecondaryBorder,
                        textStyle: AppTypography.headlineRegular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
