import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/create_smeta_item_bloc/create_estimate_item_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/create_item_widget.dart';

@RoutePage()
class CreateEstimateItemScreen extends StatefulWidget {
  const CreateEstimateItemScreen({super.key, required this.estimateId});

  final int estimateId;

  @override
  State<CreateEstimateItemScreen> createState() =>
      _CreateEstimateItemScreenState();
}

class _CreateEstimateItemScreenState extends State<CreateEstimateItemScreen> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    TextEditingController nameController = TextEditingController();
    TextEditingController categoryController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.uiBgPanels,
      appBar: AppBar(
        backgroundColor: AppColors.uiBgPanels,
        centerTitle: true,
        title: Text(
          'Добавить позицию',
          style: AppTypography.headlineRegular.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        leadingWidth: 68.w,
        leading: GestureDetector(
          onTap: () {
            context.router.pop();
          },
          child: Row(
            children: [
              Gap(15.w),
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
                style: AppTypography.caption1Regular.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<CreateEstimateItemBloc, CreateEstimateItemState>(
        listener: (BuildContext context, CreateEstimateItemState state) {
          if (state is AddEstimateItemSuccessState) {
            context.router.pop();
          }
        },
        builder: (BuildContext context, CreateEstimateItemState state) {
          if (state is ShowCreateEstimateItemState) {
            return ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
                  height: 1.h,
                  width: deviceWidth,
                  color: AppColors.uiBorder,
                ),
                Gap(28.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: DefaultTextFormField(
                    height: 44.h,
                    hintText: 'Введите название позиции',
                    hintStyle: AppTypography.headlineRegular
                        .copyWith(color: AppColors.purple800),
                    controller: nameController,
                    borderRadius: 8,
                  ),
                ),
                Gap(12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: DefaultTextFormField(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => DraggableScrollableSheet(
                          initialChildSize: 482 / 812,
                          minChildSize: 450 / 812,
                          maxChildSize: 485 / 812,
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
                                  ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: state.worksAndIcons.length,
                                    separatorBuilder: (context, _) {
                                      return Gap(16.h);
                                    },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool isWorkSelected = state.workType ==
                                          state.worksAndIcons[index].workType;
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<CreateEstimateItemBloc>()
                                              .add(
                                                ChangeEstimatePropertiesEvent(
                                                  workType: state
                                                      .worksAndIcons[index]
                                                      .workType,
                                                ),
                                              );
                                          setState(() {
                                            categoryController.clear();
                                            categoryController.text = state
                                                .worksAndIcons[index].workType;
                                          });

                                          context.router.pop();
                                        },
                                        child: Row(
                                          children: [
                                            Gap(3.5.w),
                                            Text(
                                              state.worksAndIcons[index]
                                                  .workType,
                                              style:
                                                  AppTypography.h5Bold.copyWith(
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              height: 16.h,
                                              width: 16.w,
                                              decoration: BoxDecoration(
                                                color: isWorkSelected
                                                    ? AppColors.gradient1
                                                    : AppColors.uiBackground,
                                                borderRadius:
                                                    BorderRadius.circular(45.r),
                                                border: Border.all(
                                                  color: isWorkSelected
                                                      ? AppColors.gradient1
                                                      : AppColors
                                                          .uiSecondaryBorder,
                                                ),
                                              ),
                                              child: isWorkSelected
                                                  ? const Icon(
                                                      Icons.check,
                                                      size: 12,
                                                      color: Colors.white,
                                                    )
                                                  : null,
                                            ),
                                            Gap(6.w),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    height: 44.h,
                    hintText: 'Выберите категорию',
                    hintStyle: AppTypography.headlineRegular
                        .copyWith(color: AppColors.purple800),
                    controller: categoryController,
                    borderRadius: 8,
                    readOnly: true,
                  ),
                ),
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: const CreateItemWidget(),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomSheet: BlocBuilder<CreateEstimateItemBloc, CreateEstimateItemState>(
        builder: (BuildContext context, CreateEstimateItemState state) {
          if (state is ShowCreateEstimateItemState) {
            return Container(
              height: 92.h,
              decoration: const BoxDecoration(
                color: AppColors.uiBgPanels,
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColors.uiBorder,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                children: [
                  Gap(8.h),
                  SizedBox(
                    height: 46.h,
                    child: DefaultButtonWidget(
                      onTap: () {
                        context.read<CreateEstimateItemBloc>().add(
                              AddEstimateItemEvent(
                                estimateId: widget.estimateId,
                                positionName: nameController.text,
                                item: EstimateItemModel(
                                  itemId: 0,
                                  workType: categoryController.text,
                                  unit: state.unit,
                                  quantity: state.quantity,
                                  pricePerOne: state.pricePerOne,
                                  clientPricePerOne: state.clientPricePerOne,
                                  cost: state.cost,
                                  clientCost: state.clientCost,
                                  markup: state.markup,
                                ),
                              ),
                            );
                      },
                      buttonText: 'Сохранить',
                      textStyle: AppTypography.headlineRegular.copyWith(
                        color: AppColors.buttonPrimaryText,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
