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
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/manage_smeta_filters_widget.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/manage_smeta_item_widget.dart';

@RoutePage()
class ManageSmetaScreen extends StatelessWidget {
  const ManageSmetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: AppColors.uiBgPanels,
        body: BlocConsumer<ManageSmetaBloc, ManageSmetaState>(
          listener: (BuildContext context, ManageSmetaState state) {
            if (state is UpdateItemsSuccessState) {
              context.router.navigate(
                const HomeWrapperRoute(),
              );
            }
          },
          builder: (BuildContext context, ManageSmetaState state) {
            if (state is ShowManageSmetaState) {
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  top: 58.h,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      children: [
                        Text(
                          'Бюджетная смета',
                          style: AppTypography.headlineMedium
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        const Spacer(),
                        DefaultIconButtonWidget(
                          icon: 'assets/icons/ic_settings.svg',
                          iconWidth: 18.46.w,
                          iconHeight: 20.31.h,
                        ),
                        Gap(8.w),
                        GestureDetector(
                          onTap: () {
                            context.read<ManageSmetaBloc>().add(
                                  UpdateEstimateItemsEvent(),
                                );
                          },
                          child: DefaultIconButtonWidget(
                            icon: 'assets/icons/ic_close.svg',
                            iconWidth: 12.w,
                            iconHeight: 12.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(15.h),
                  const Divider(
                    color: AppColors.uiBorder,
                  ),
                  Gap(14.h),
                  const ManageSmetaFiltersWidget(),
                  Gap(14.h),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.estimateItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, _) {
                      return const Divider(
                        color: AppColors.uiBorder,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: ManageSmetaItemWidget(
                          estimateItem: state.estimateItems[index][1],
                          isExpandedItem: state.estimateItems[index][0],
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
        bottomSheet: Container(
          height: 92.h,
          decoration: const BoxDecoration(
            color: AppColors.uiBgPanels,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: AppColors.uiBorder,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            top: 8.h,
            left: 15.w,
            right: 15.w,
            bottom: 38.h,
          ),
          child: SizedBox(
            height: 46.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.router.push(const CreateEstimateItemRoute());
                  },
                  child: Container(
                    height: 46.h,
                    width: 288.w,
                    decoration: BoxDecoration(
                      color: AppColors.buttonPrimaryBg,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 60.w,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Добавить позицию',
                            style: AppTypography.headlineRegular.copyWith(
                              color: AppColors.buttonPrimaryText,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/ic_plus.svg',
                            width: 13.w,
                            height: 13.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.colorD9D9D9,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 45.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: AppColors.buttonPrimaryBg,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/ic_share.svg',
                        width: 24.w,
                        height: 24.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.buttonPrimaryText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
