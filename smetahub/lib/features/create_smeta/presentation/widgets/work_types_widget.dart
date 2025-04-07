import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/create_smeta/presentation/bloc/create_smeta_bloc.dart';

class WorkTypesWidget extends StatelessWidget {
  const WorkTypesWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.workOptions,
    required this.iconHeight,
    required this.iconWidth,
  });

  final String icon;
  final double iconHeight;
  final double iconWidth;
  final String title;
  final List workOptions;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateSmetaBloc, CreateSmetaState>(
      listener: (BuildContext context, CreateSmetaState state) {},
      builder: (BuildContext context, CreateSmetaState state) {
        if (state is ShowCreateSmetaState) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.transparent,
              border: Border.symmetric(
                horizontal: BorderSide(color: AppColors.uiBorder),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 17.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Gap(3.5.w),
                    SvgPicture.asset(
                      icon,
                      width: iconWidth,
                      height: iconHeight,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    Gap(9.w),
                    Text(
                      title,
                      style: AppTypography.h5Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<CreateSmetaBloc>().add(
                              ChooseAllSectionOptionsEvent(
                                sectionOptions: workOptions,
                              ),
                            );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.gray300A18,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        child: Text(
                          'Выбрать все',
                          style: AppTypography.caption1Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Gap(16.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 8.h,
                  children: List.generate(
                    workOptions.length,
                    (index) {
                      final bool isSelected = state.selectedWorkOptions
                          .contains(workOptions[index]);

                      return GestureDetector(
                        onTap: () {
                          context.read<CreateSmetaBloc>().add(
                                AddWorkOptionEvent(
                                  workOption: workOptions[index],
                                ),
                              );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21.r),
                            color:
                                isSelected ? null : AppColors.buttonSecondaryBg,
                            gradient: isSelected
                                ? const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.gradient2,
                                      AppColors.gradient1,
                                    ],
                                  )
                                : null,
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: AppColors.buttonSecondaryBorder,
                                  ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 10.w,
                          ).copyWith(
                            right: 16.w,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isSelected
                                  ? SvgPicture.asset(
                                      'assets/icons/ic_tick.svg',
                                      width: 11.w,
                                      height: 11.h,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white100,
                                        BlendMode.srcIn,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/ic_plus.svg',
                                      width: 11.w,
                                      height: 11.h,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.textPrimary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                              Gap(5.w),
                              Text(
                                '${workOptions[index].name}',
                                style: AppTypography.headlineRegular.copyWith(
                                  color: isSelected
                                      ? AppColors.white100
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
