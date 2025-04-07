import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';

class AiConsultantsWidget extends StatelessWidget {
  const AiConsultantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {},
      builder: (BuildContext context, HomeState state) {
        if (state is ShowHomeState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ИИ консультанты',
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      height: 20.h,
                      width: 37.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.gray300A18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${state.aiAgents.length}',
                            style: AppTypography.caption1Regular.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/ic_arrow_right.svg',
                            width: 6.w,
                            height: 11.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.textPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(15.h),
              SizedBox(
                height: 42.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.aiAgents.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(10.w);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.uiBgPanels,
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: [
                          if (index == 0) Gap(10.w),
                          Gap(10.w),
                          CircleAvatar(
                            radius: 13.r,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(66.r),
                              child: state.aiAgents[index].image != null
                                  ? Image.network(
                                      state.aiAgents[index].image!,
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                          Gap(8.w),
                          Text(
                            state.aiAgents[index].name,
                            style: AppTypography.subheadsMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(3.4.w),
                          SvgPicture.asset(
                            'assets/icons/ic_consultant_star.svg',
                            width: 13.27.w,
                            height: 14.5.h,
                          ),
                          Gap(16.w),
                          if (index == state.aiAgents.length - 1) Gap(10.w),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
