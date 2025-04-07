import 'package:auto_route/auto_route.dart';
import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/single_item_widget.dart';

class ManageSmetaItemWidget extends StatefulWidget {
  const ManageSmetaItemWidget({
    super.key,
    required this.estimateItem,
    // required this.units,
    required this.isExpandedItem,
  });

  final EstimateItemModel estimateItem;
  // final List<UnitModel> units;
  final bool isExpandedItem;

  @override
  State<ManageSmetaItemWidget> createState() => _ManageSmetaItemWidgetState();
}

class _ManageSmetaItemWidgetState extends State<ManageSmetaItemWidget> {
  late int cost;
  late int clientCost;

  @override
  void initState() {
    super.initState();
    setState(() {
      cost = (widget.estimateItem.pricePerOne * widget.estimateItem.quantity)
          .toInt();
      // metricController.text = widget.estimateItem.unit;
      // selectedUnit = widget.estimateItem.unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<ManageSmetaBloc, ManageSmetaState>(
      listener: (BuildContext context, ManageSmetaState state) {},
      builder: (BuildContext context, ManageSmetaState state) {
        if (state is ShowManageSmetaState) {
          return ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            elevation: 0,
            children: [
              ExpansionPanel(
                isExpanded: widget.isExpandedItem,
                canTapOnHeader: true,
                backgroundColor: AppColors.transparent,
                headerBuilder: (BuildContext context, bool ispen) {
                  return SizedBox(
                    height: 32.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 212.w,
                          child: Text(
                            widget.estimateItem.workType,
                            style: AppTypography.subheadsMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Gap(4.w),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.blue700A18,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 88.w,
                            minHeight: 24.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 8.w,
                          ),
                          child: Text(
                            '$cost ₸',
                            style: AppTypography.subheadsMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                body: Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: Column(
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
                                  builder: (context) =>
                                      DraggableScrollableSheet(
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
                                                color:
                                                    AppColors.uiSecondaryBorder,
                                                borderRadius:
                                                    BorderRadius.circular(26.r),
                                              ),
                                            ),
                                            Gap(22.h),
                                            Text(
                                              'Выберите единицу измерения',
                                              style: AppTypography.h5Bold
                                                  .copyWith(
                                                      color: AppColors
                                                          .textPrimary),
                                            ),
                                            Gap(36.h),
                                            ListView.separated(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w),
                                              shrinkWrap: true,
                                              separatorBuilder: (context, _) {
                                                return Gap(16.h);
                                              },
                                              itemCount: state.units.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<ManageSmetaBloc>()
                                                        .add(
                                                          ChangeEstimatePropertiesEvent(
                                                            itemId: widget
                                                                .estimateItem
                                                                .itemId,
                                                            unit: state
                                                                .units[index]
                                                                .name,
                                                          ),
                                                        );
                                                    setState(() {});
                                                    context.router.pop();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 9.h,
                                                      horizontal: 16.w,
                                                    ),
                                                    decoration: widget
                                                                .estimateItem
                                                                .unit ==
                                                            state.units[index]
                                                                .name
                                                        ? ShapeDecoration(
                                                            color: AppColors
                                                                .transparent,
                                                            shape: FancyBorder(
                                                              shape:
                                                                  const RoundedRectangleBorder(),
                                                              width: 1,
                                                              gradient:
                                                                  const LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .gradient1,
                                                                  AppColors
                                                                      .gradient2,
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                              corners: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          13.r)),
                                                            ),
                                                          )
                                                        : BoxDecoration(
                                                            color: AppColors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.r),
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .uiSecondaryBorder,
                                                            ),
                                                          ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          state.units[index]
                                                              .name,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: widget
                                                                        .estimateItem
                                                                        .unit ==
                                                                    state
                                                                        .units[
                                                                            index]
                                                                        .name
                                                                ? AppColors
                                                                    .gradient1
                                                                : AppColors
                                                                    .uiBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        45.r),
                                                            border: Border.all(
                                                              color: widget.estimateItem
                                                                          .unit ==
                                                                      state
                                                                          .units[
                                                                              index]
                                                                          .name
                                                                  ? AppColors
                                                                      .gradient1
                                                                  : AppColors
                                                                      .uiSecondaryBorder,
                                                            ),
                                                          ),
                                                          child: widget
                                                                      .estimateItem
                                                                      .unit ==
                                                                  state
                                                                      .units[
                                                                          index]
                                                                      .name
                                                              ? const Icon(
                                                                  Icons.check,
                                                                  size: 12,
                                                                  color: Colors
                                                                      .white,
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
                                  vertical: 6.h,
                                  horizontal: 16.w,
                                ),
                                child: Text(
                                  widget.estimateItem.unit,
                                  style: AppTypography.headlineRegular.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleItemWidget(
                        text: 'Кол-во',
                        amount: widget.estimateItem.quantity.toInt(),
                        metric: 'м²',
                        onChanged: (value) {
                          context.read<ManageSmetaBloc>().add(
                                ChangeEstimatePropertiesEvent(
                                  itemId: widget.estimateItem.itemId,
                                  quantity: int.tryParse(value)?.toDouble(),
                                  // cost: ,
                                  // clientCost: ,
                                ),
                              );
                          // setState(() {
                          //   cost = int.tryParse(value) *
                          // });
                        },
                      ),
                      SingleItemWidget(
                        text: 'Цена за 1',
                        amount: widget.estimateItem.pricePerOne.toInt(),
                        metric: '₸',
                        onChanged: (value) {
                          context.read<ManageSmetaBloc>().add(
                                ChangeEstimatePropertiesEvent(
                                  itemId: widget.estimateItem.itemId,
                                  pricePerOne: int.tryParse(value)?.toDouble(),
                                  cost: (int.tryParse(value)?.toDouble() ?? 0) *
                                      5,
                                ),
                              );
                          setState(() {});
                        },
                      ),
                      SingleItemWidget(
                        text: 'Стоимость',
                        amount: cost,
                        metric: '₸',
                        onChanged: (_) {},
                        readOnly: true,
                      ),
                      SingleItemWidget(
                        text: 'Наценка, %',
                        amount: widget.estimateItem.markup.toInt(),
                        metric: '%',
                        onChanged: (value) {
                          context.read<ManageSmetaBloc>().add(
                                ChangeEstimatePropertiesEvent(
                                  itemId: widget.estimateItem.itemId,
                                  markup: int.tryParse(value)?.toDouble(),
                                ),
                              );
                          setState(() {});
                        },
                      ),
                      SingleItemWidget(
                        text: 'Цена для заказчика за 1',
                        amount: widget.estimateItem.clientPricePerOne.toInt(),
                        metric: '₸',
                        onChanged: (value) {
                          context.read<ManageSmetaBloc>().add(
                                ChangeEstimatePropertiesEvent(
                                  itemId: widget.estimateItem.itemId,
                                  clientPricePerOne:
                                      int.tryParse(value)?.toDouble(),
                                  clientCost:
                                      (int.tryParse(value)?.toDouble() ?? 0) *
                                          5,
                                ),
                              );
                          setState(() {});
                        },
                      ),
                      SingleItemWidget(
                        text: 'Стоимость для заказчика',
                        amount: (widget.estimateItem.clientPricePerOne *
                                widget.estimateItem.quantity)
                            .toInt(),
                        metric: '₸',
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
