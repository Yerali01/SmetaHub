import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/create_smeta_item_bloc/create_estimate_item_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/create_single_item_widget.dart';

class CreateItemWidget extends StatefulWidget {
  const CreateItemWidget({
    super.key,
  });

  @override
  State<CreateItemWidget> createState() => _CreateItemWidgetState();
}

class _CreateItemWidgetState extends State<CreateItemWidget> {
  final TextEditingController metricController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<CreateEstimateItemBloc, CreateEstimateItemState>(
      builder: (context, state) {
        if (state is ShowCreateEstimateItemState) {
          log('CHANGED QUANTITY ${state.quantity} AND COST ${state.cost}');

          double cost = state.cost;
          double clientCost = state.clientCost;
          double markup = state.markup;
          return Column(
            spacing: 8.h,
            children: [
              SizedBox(
                height: 30.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ед. изм.',
                      style: AppTypography.caption1Medium.copyWith(
                        color: AppColors.text635D8A,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => DraggableScrollableSheet(
                            initialChildSize: 664 / 812,
                            minChildSize: 450 / 812,
                            maxChildSize: 670 / 812,
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
                                        borderRadius:
                                            BorderRadius.circular(26.r),
                                      ),
                                    ),
                                    Gap(22.h),
                                    Text(
                                      'Выберите единицу измерения',
                                      style: AppTypography.h5Bold.copyWith(
                                          color: AppColors.textPrimary),
                                    ),
                                    Gap(36.h),
                                    ListView.separated(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, _) {
                                        return Gap(16.h);
                                      },
                                      itemCount: state.units.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        bool isSelected = state.unit ==
                                            state.units[index].name;

                                        return GestureDetector(
                                          onTap: () {
                                            context
                                                .read<CreateEstimateItemBloc>()
                                                .add(
                                                  ChangeEstimatePropertiesEvent(
                                                    unit:
                                                        state.units[index].name,
                                                  ),
                                                );
                                            setState(() {});
                                            context.router.pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 9.h,
                                              horizontal: 16.w,
                                            ),
                                            decoration: isSelected
                                                ? ShapeDecoration(
                                                    color:
                                                        AppColors.transparent,
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      corners: BorderRadius.all(
                                                        Radius.circular(13.r),
                                                      ),
                                                    ),
                                                  )
                                                : BoxDecoration(
                                                    color:
                                                        AppColors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13.r),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .uiSecondaryBorder,
                                                    ),
                                                  ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  state.units[index].name,
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
                                                        : AppColors
                                                            .uiBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            45.r),
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 30.h,
                        width: 121.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.inputBorder,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 16.w,
                        ),
                        child: Row(
                          children: [
                            Text(
                              state.unit,
                              style: AppTypography.headlineRegular.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/icons/ic_arrow_down.svg',
                              width: 10.5.w,
                              height: 6.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CreateSingleItemWidget(
                text: 'Кол-во',
                amount: state.quantity,
                metric: 'м²',
                onChanged: (value) {
                  double quantity = double.tryParse(value) ?? 0;
                  context.read<CreateEstimateItemBloc>().add(
                        ChangeEstimatePropertiesEvent(
                          quantity: quantity,
                          cost: quantity * state.pricePerOne,
                          clientCost: quantity * state.clientPricePerOne,
                        ),
                      );
                  setState(() {});
                },
              ),
              CreateSingleItemWidget(
                text: 'Цена за 1',
                amount: state.pricePerOne,
                metric: '₸',
                onChanged: (value) {
                  double ppOne = double.tryParse(value) ?? 0;
                  context.read<CreateEstimateItemBloc>().add(
                        ChangeEstimatePropertiesEvent(
                          pricePerOne: ppOne,
                          markup: 100 * state.clientPricePerOne / ppOne,
                          clientPricePerOne:
                              ppOne + ((state.markup * ppOne) / 100),
                          cost: state.quantity * ppOne,
                        ),
                      );
                  setState(() {});
                },
              ),
              CreateSingleItemWidget(
                text: 'Стоимость',
                amount: cost,
                metric: '₸',
                readOnly: true,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              CreateSingleItemWidget(
                text: 'Наценка, %',
                amount: markup,
                metric: '%',
                onChanged: (value) {
                  double markUp = double.tryParse(value) ?? 0;
                  context.read<CreateEstimateItemBloc>().add(
                        ChangeEstimatePropertiesEvent(
                          markup: markUp,
                          clientPricePerOne: state.pricePerOne +
                              ((markUp * state.pricePerOne) / 100),
                        ),
                      );
                  setState(() {});
                },
              ),
              CreateSingleItemWidget(
                text: 'Цена для заказчика за 1',
                amount: 0,
                metric: '₸',
                onChanged: (value) {
                  double cppOne = double.tryParse(value) ?? 0;
                  context.read<CreateEstimateItemBloc>().add(
                        ChangeEstimatePropertiesEvent(
                          clientPricePerOne: cppOne,
                          clientCost: state.quantity * cppOne,
                          markup: 100 * cppOne / state.pricePerOne,
                        ),
                      );
                  setState(() {});
                },
              ),
              CreateSingleItemWidget(
                text: 'Стоимость для заказчика',
                amount: clientCost,
                metric: '₸',
                readOnly: true,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
