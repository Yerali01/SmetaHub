import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';

class CreateProjectBottomSheetWidget extends StatelessWidget {
  const CreateProjectBottomSheetWidget({
    super.key,
    required this.title,
    required this.height,
    required this.mainInformation,
    required this.onTap,
  });

  final String title;
  final double height;
  final List<List<String>> mainInformation;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 38.h,
        left: 15.w,
        right: 15.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 82.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.uiSecondaryBorder,
              borderRadius: BorderRadius.circular(26.r),
            ),
            child: Divider(
              color: AppColors.uiSecondaryBorder,
              height: 4.h,
            ),
          ),
          Gap(22.h),
          Text(
            title,
            style: AppTypography.h5Bold.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
          Gap(36.h),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mainInformation.length,
            separatorBuilder: (context, index) => Gap(16.h),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainInformation[index][0],
                    style: AppTypography.subheadsBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    mainInformation[index][1],
                    style: AppTypography.caption1Regular.copyWith(
                      color: AppColors.gray300,
                    ),
                  ),
                ],
              );
            },
          ),
          Gap(26.h),
          DefaultButtonWidget(
            onTap: onTap,
            backgroundColor: AppColors.buttonPrimaryBg,
            buttonText: 'Ок',
            textStyle: AppTypography.headlineRegular
                .copyWith(color: AppColors.buttonPrimaryText),
          ),
        ],
      ),
    );
  }
}
