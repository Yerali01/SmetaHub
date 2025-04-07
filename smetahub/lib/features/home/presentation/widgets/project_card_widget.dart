import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/container_text_widget.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 14.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border.all(
          color: AppColors.uiSecondaryBorder,
        ),
        borderRadius: BorderRadius.circular(13.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/ic_location_marker.svg',
                width: 11.5.w,
                height: 13.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
              Gap(7.w),
              Text(
                project.name ?? '',
                style: AppTypography.subheadsMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Gap(12.h),
          Row(
            children: [
              if (project.files != null && project.files!.isNotEmpty)
                Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: project.files?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          width: 150.w,
                          height: 100.h,
                          project.files?[index].downloadUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              if (project.files?.length == 0)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    width: 150.w,
                    height: 100.h,
                    'assets/images/no_photo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              Gap(15.h),
              Container(
                color: AppColors.transparent,
                width: 150.w,
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 5.h,
                  children: [
                    if (project.objectType?.name != null)
                      ContainerTextWidget(
                        text: project.objectType!.name!,
                      ),
                    if (project.objectCondition?.name != null)
                      ContainerTextWidget(
                        text: project.objectCondition!.name!,
                      ),
                    if (project.technicalConditions?.area != null)
                      ContainerTextWidget(
                        text: '${project.technicalConditions?.area} м²',
                      ),
                    if (project.technicalConditions?.area != null)
                      ContainerTextWidget(
                          text: '',
                          bgColor: AppColors.blue700A18,
                          childWidget: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/ic_paper_list.svg',
                                width: 7.w,
                                height: 9.h,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.blue700,
                                  BlendMode.srcIn,
                                ),
                              ),
                              Gap(8.w),
                              Text(
                                '${project.technicalConditions?.area} м²',
                                style: AppTypography.subheadsMedium.copyWith(
                                  color: AppColors.blue700,
                                ),
                              ),
                            ],
                          )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
