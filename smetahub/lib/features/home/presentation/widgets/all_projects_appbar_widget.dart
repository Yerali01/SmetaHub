import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/ai_chat/presentation/widgets/default_icon_button_widget.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';

class AllProjectsAppbarWidget extends StatelessWidget {
  const AllProjectsAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is ShowHomeState) {
          if (state.showAllProjectsSort) {
            // showModalBottomSheet(
            //           context: context,
            //           isScrollControlled: true,
            //           backgroundColor: Colors.transparent,
            //           builder: (context) => DraggableScrollableSheet(
            //             initialChildSize: 244/812,
            //             minChildSize: 200 / 812,
            //             maxChildSize: 250 / 812,
            //             builder: (context, scrollController) {
            //               return Container(
            //                 padding: EdgeInsets.symmetric(
            //                   horizontal: 15.w,
            //                 ),
            //                 decoration: BoxDecoration(
            //                   color: AppColors.uiBgPanels,
            //                   borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(38.r),
            //                     topRight: Radius.circular(38.r),
            //                   ),
            //                 ),
            //                 child: ,
            //               );
            //             },
            //           ),
            //         );
          }
        }
      },
      builder: (BuildContext context, HomeState state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 25.h, top: 57.h),
          decoration: const BoxDecoration(
            color: AppColors.uiBgPanels,
            border: Border.symmetric(
              horizontal: BorderSide(color: AppColors.uiBorder),
            ),
          ),
          child: Row(
            children: [
              Gap(15.w),
              GestureDetector(
                onTap: () => context.router.navigate(const HomeWrapperRoute()),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_arrow_left.svg',
                      width: 6.w,
                      height: 10.5.h,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    Gap(10.w),
                    Text(
                      'Назад',
                      style: AppTypography.caption1Regular
                          .copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Мои проекты',
                style: AppTypography.headlineRegular
                    .copyWith(color: AppColors.textPrimary),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(
                        ShowAllProjectsSortEvent(),
                      );
                },
                child: const DefaultIconButtonWidget(
                  icon: 'assets/icons/ic_sort.svg',
                  iconWidth: 17.11,
                  iconHeight: 14.33,
                ),
              ),
              Gap(8.w),
              GestureDetector(
                onTap: () {},
                child: const DefaultIconButtonWidget(
                  icon: 'assets/icons/ic_select_all.svg',
                  iconWidth: 17.11,
                  iconHeight: 14.33,
                ),
              ),
              Gap(15.w),
            ],
          ),
        );
      },
    );
  }
}
