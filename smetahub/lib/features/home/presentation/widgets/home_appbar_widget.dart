import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';

class HomeScreenAppBarWidget extends StatelessWidget {
  const HomeScreenAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {},
      builder: (BuildContext context, HomeState state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20.r,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(66.r),
                child: Image.asset(
                  'assets/images/avatars/default_user.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                // Container(
                //   height: 34.h,
                //   width: 34.w,
                //   decoration: BoxDecoration(
                //     color: AppColors.gray300A18,
                //     borderRadius: BorderRadius.circular(10.r),
                //   ),
                //   child: Center(
                //     child: SvgPicture.asset(
                //       'assets/icons/ic_notification.svg',
                //       width: 15.w,
                //       height: 17.h,
                //       colorFilter: const ColorFilter.mode(
                //         AppColors.textPrimary,
                //         BlendMode.srcIn,
                //       ),
                //     ),
                //   ),
                // ),
                // Gap(8.w),
                // Container(
                //   height: 34.h,
                //   width: 34.w,
                //   decoration: BoxDecoration(
                //     color: AppColors.gray300A18,
                //     borderRadius: BorderRadius.circular(10.r),
                //   ),
                //   child: Center(
                //     child: SvgPicture.asset(
                //       'assets/icons/ic_settings.svg',
                //       width: 18.w,
                //       height: 20.h,
                //       colorFilter: const ColorFilter.mode(
                //         AppColors.textPrimary,
                //         BlendMode.srcIn,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        );
      },
    );
  }
}
