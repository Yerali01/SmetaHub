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
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {},
        builder: (BuildContext context, HomeState state) {
          if (state is ShowHomeState) {
            final List<ProjectModel> allProjects = state.projects;
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
                    return ProjectCardWidget(project: allProjects[index]);
                  },
                ),
                Gap(16.h),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
