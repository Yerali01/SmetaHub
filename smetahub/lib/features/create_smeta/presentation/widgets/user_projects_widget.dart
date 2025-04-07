import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/container_text_widget.dart';

class UserProjectsWidget extends StatelessWidget {
  const UserProjectsWidget({
    super.key,
    required this.project,
    this.onTap,
    this.isSelected = false,
  });

  final ProjectModel project;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 345.w,
        height: 175.h,
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 14.w,
        ),
        decoration: isSelected
            ? ShapeDecoration(
                color: AppColors.transparent,
                shape: FancyBorder(
                  shape: const RoundedRectangleBorder(),
                  width: 1,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.gradient1,
                      AppColors.gradient2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  corners: BorderRadius.all(Radius.circular(13.r)),
                ),
              )
            : BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(13.r),
                border: Border.all(
                  color: AppColors.uiSecondaryBorder,
                  width: 1,
                ),
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
                const Spacer(),
                Container(
                  height: 16.h,
                  width: 16.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.gradient1
                        : AppColors.uiBackground,
                    borderRadius: BorderRadius.circular(45.r),
                    border: Border.all(
                      color: AppColors.uiSecondaryBorder,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
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
      ),
    );
  }
}
