import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/colors.dart';

class LinearProgressBarWidget extends StatelessWidget {
  const LinearProgressBarWidget({
    super.key,
    required this.percentage,
  });

  /// format is 0.12
  final double percentage;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: 4.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.r),
            color: AppColors.uiBackground,
          ),
        ),
        Container(
          height: 4.h,
          width: deviceWidth * percentage,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.r),
            gradient: const LinearGradient(
              colors: [
                AppColors.gradient1,
                AppColors.gradient2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ],
    );
  }
}
