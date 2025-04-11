import 'package:auto_route/auto_route.dart';
import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc/manage_smeta_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/filter_buttons_widget.dart';

class ManageSmetaFiltersWidget extends StatelessWidget {
  const ManageSmetaFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    final List<String> sortTypes = [
      "Сначала дешевые",
      "Сначала дорогие",
      "По порядку работ",
      "Сначала финишные работы",
    ];

    return BlocConsumer<ManageSmetaBloc, ManageSmetaState>(
      listener: (BuildContext context, ManageSmetaState state) {},
      builder: (BuildContext context, ManageSmetaState state) {
        if (state is ShowManageSmetaState) {
          return Container(
            height: 34.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButtonsWidget(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 580 / 812,
                        minChildSize: 400 / 812,
                        maxChildSize: 582 / 812,
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
                          );
                        },
                      ),
                    );
                  },
                  iconPath: 'assets/icons/ic_sort.svg',
                  iconWidth: 9.64.w,
                  iconHeight: 9.64.h,
                  text: 'Фильтровать',
                ),
                FilterButtonsWidget(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 360 / 812,
                        minChildSize: 200 / 812,
                        maxChildSize: 364 / 812,
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
                            width: deviceWidth,
                            child: Column(
                              children: [
                                Gap(10.h),
                                Container(
                                  width: 82.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.uiSecondaryBorder,
                                    borderRadius: BorderRadius.circular(26.r),
                                  ),
                                ),
                                Gap(22.h),
                                Text(
                                  'Сортировать',
                                  style: AppTypography.h5Bold
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                                Gap(36.h),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: sortTypes.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Gap(16.h);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    bool isSelected =
                                        state.sortingType == sortTypes[index];
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<ManageSmetaBloc>()
                                            .add(SelectSortingTypeEvent(
                                              sortingType: sortTypes[index],
                                            ));
                                        context.router.pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 14.h,
                                          horizontal: 16.w,
                                        ),
                                        decoration: isSelected
                                            ? ShapeDecoration(
                                                color: AppColors.transparent,
                                                shape: FancyBorder(
                                                  shape:
                                                      const RoundedRectangleBorder(),
                                                  width: 1,
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      AppColors.gradient1,
                                                      AppColors.gradient2,
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  corners: BorderRadius.all(
                                                      Radius.circular(13.r)),
                                                ),
                                              )
                                            : BoxDecoration(
                                                color: AppColors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(13.r),
                                                border: Border.all(
                                                  color: AppColors.gray100,
                                                ),
                                              ),
                                        child: Row(
                                          children: [
                                            Text(
                                              sortTypes[index],
                                              style: AppTypography
                                                  .subheadsMedium
                                                  .copyWith(
                                                      color: AppColors
                                                          .textPrimary),
                                            ),
                                            const Spacer(),
                                            Container(
                                              height: 16.h,
                                              width: 16.w,
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? AppColors.gradient1
                                                    : AppColors.uiBackground,
                                                borderRadius:
                                                    BorderRadius.circular(45.r),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? AppColors.gradient1
                                                      : AppColors
                                                          .uiSecondaryBorder,
                                                ),
                                              ),
                                              child: isSelected
                                                  ? const Icon(
                                                      Icons.check,
                                                      size: 12,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  iconPath: state.sortingType != null
                      ? 'assets/icons/ic_sort_selected.svg'
                      : 'assets/icons/ic_sort.svg',
                  iconHeight: state.sortingType != null ? 16.h : 9.55.h,
                  iconWidth: state.sortingType != null ? 16.w : 11.41.w,
                  text: 'Сортировать',
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
