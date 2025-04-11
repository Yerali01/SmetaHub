import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';
import 'package:smetahub/features/home/presentation/widgets/all_projects_appbar_widget.dart';
import 'package:smetahub/features/home/presentation/widgets/project_card_widget.dart';

@RoutePage()
class AllProjectsScreen extends StatelessWidget {
  const AllProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.uiBgPanels,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is ShowHomeState) {
            final List<ProjectModel> allProjects = state.projects.where((item) {
              return item.status != 'Completed';
            }).toList();
            final List<ProjectModel> allFinishedProjects =
                state.projects.where((item) {
              return item.status == "Completed";
            }).toList();
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 62.h),
              children: [
                const AllProjectsAppbarWidget(),
                Gap(16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: DefaultButtonWidget(
                    onTap: () {
                      context.router.push(const CreateProjectWrapperRoute());
                    },
                    buttonText: '',
                    buttonWidget: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Создать новый проект',
                          style: AppTypography.subheadsMedium
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        Gap(5.w),
                        SvgPicture.asset(
                          'assets/icons/ic_plus.svg',
                          width: 13.w,
                          height: 13.h,
                          colorFilter: const ColorFilter.mode(
                            AppColors.textPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: AppColors.transparent,
                    borderColor: AppColors.uiSecondaryBorder,
                    textStyle: AppTypography.headlineRegular
                        .copyWith(color: AppColors.buttonPrimaryText),
                  ),
                ),
                Gap(16.h),
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allProjects.length,
                  separatorBuilder: (BuildContext context, _) {
                    return Gap(16.h);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 430 / 812,
                            minChildSize: 400 / 812,
                            maxChildSize: 440 / 812,
                            builder: (context, scrollController) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.uiBgPanels,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(38.r),
                                    topRight: Radius.circular(38.r),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Gap(10.h),
                                    Container(
                                      width: 82.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.uiSecondaryBorder,
                                        borderRadius:
                                            BorderRadius.circular(26.r),
                                      ),
                                    ),
                                    Gap(22.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/ic_location_marker.svg',
                                          width: 12.w,
                                          height: 13.16.h,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.textPrimary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Gap(7.24.w),
                                        Text(
                                          '${allProjects[index].name}',
                                          style: AppTypography.subheadsMedium
                                              .copyWith(
                                                  color: AppColors.textPrimary),
                                        ),
                                      ],
                                    ),
                                    Gap(36.h),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: ProjectCardWidget(
                        project: allProjects[index],
                      ),
                    );
                  },
                ),
                Gap(16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: DefaultButtonWidget(
                    onTap: () {},
                    height: 46.h,
                    buttonText: '',
                    backgroundColor: AppColors.buttonSecondaryBg,
                    borderColor: AppColors.buttonSecondaryBorder,
                    buttonWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Показать завершенные (${allFinishedProjects.length})',
                          style: AppTypography.headlineRegular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                    top: 16.h,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: allFinishedProjects.length,
                  separatorBuilder: (BuildContext context, _) {
                    return Gap(16.h);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 430 / 812,
                            minChildSize: 400 / 812,
                            maxChildSize: 440 / 812,
                            builder: (context, scrollController) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.uiBgPanels,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(38.r),
                                    topRight: Radius.circular(38.r),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Gap(10.h),
                                    Container(
                                      width: 82.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.uiSecondaryBorder,
                                        borderRadius:
                                            BorderRadius.circular(26.r),
                                      ),
                                    ),
                                    Gap(22.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/ic_location_marker.svg',
                                          width: 12.w,
                                          height: 13.16.h,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.textPrimary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        Gap(7.24.w),
                                        Text(
                                          '${allFinishedProjects[index].name}',
                                          style: AppTypography.subheadsMedium
                                              .copyWith(
                                                  color: AppColors.textPrimary),
                                        ),
                                      ],
                                    ),
                                    Gap(36.h),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: ProjectCardWidget(
                        project: allFinishedProjects[index],
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
