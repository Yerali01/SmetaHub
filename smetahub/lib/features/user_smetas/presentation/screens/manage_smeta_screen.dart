import 'package:auto_route/auto_route.dart';
import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/features/ai_chat/presentation/widgets/default_icon_button_widget.dart';
import 'package:smetahub/features/user_smetas/domain/models/estimate_item_model.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc/manage_smeta_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/manage_single_item_widget.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/manage_smeta_filters_widget.dart';

@RoutePage()
class ManageSmetaScreen extends StatefulWidget {
  const ManageSmetaScreen({super.key});

  @override
  State<ManageSmetaScreen> createState() => _ManageSmetaScreenState();
}

class _ManageSmetaScreenState extends State<ManageSmetaScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    currentTabIndex = 0;

    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

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
                  bottom: 125.h,
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
                      EstimateItemModel estimateItem =
                          state.estimateItems[index][1];

                      bool isExpandedItem = state.estimateItems[index][0];

                      double clientCost = (estimateItem.quantity *
                          estimateItem.clientPricePerOne);
                      double clientPricePerOne = estimateItem.clientPricePerOne;
                      double percent = estimateItem.markup;
                      double cost = estimateItem.cost;
                      double pricePerOne = estimateItem.pricePerOne;
                      double quantity = estimateItem.quantity;

                      return Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: ExpansionPanelList(
                          expandedHeaderPadding: EdgeInsets.zero,
                          elevation: 0,
                          children: [
                            ExpansionPanel(
                              isExpanded: isExpandedItem,
                              canTapOnHeader: true,
                              backgroundColor: AppColors.transparent,
                              headerBuilder:
                                  (BuildContext context, bool ispen) {
                                return SizedBox(
                                  height: 33.h,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 212.w,
                                        child: Text(
                                          estimateItem.workType,
                                          style: AppTypography.subheadsMedium
                                              .copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                      ),
                                      Gap(4.w),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.blue700A18,
                                          borderRadius:
                                              BorderRadius.circular(6.r),
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
                                          style: AppTypography.subheadsMedium
                                              .copyWith(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ед. изм.',
                                            style: AppTypography.caption1Medium
                                                .copyWith(
                                              color: AppColors.text635D8A,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) =>
                                                    DraggableScrollableSheet(
                                                  initialChildSize: 664 / 812,
                                                  minChildSize: 450 / 812,
                                                  maxChildSize: 670 / 812,
                                                  builder: (context,
                                                      scrollController) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .uiBgPanels,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  38.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  38.r),
                                                        ),
                                                      ),
                                                      width: deviceWidth,
                                                      child: Column(
                                                        children: [
                                                          Gap(10.h),
                                                          Container(
                                                            width: 82.w,
                                                            height: 4.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .uiSecondaryBorder,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          26.r),
                                                            ),
                                                          ),
                                                          Gap(22.h),
                                                          Text(
                                                            'Выберите единицу измерения',
                                                            style: AppTypography
                                                                .h5Bold
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .textPrimary),
                                                          ),
                                                          Gap(36.h),
                                                          ListView.separated(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15.w),
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            separatorBuilder:
                                                                (context, _) {
                                                              return Gap(16.h);
                                                            },
                                                            itemCount: state
                                                                .units.length,
                                                            itemBuilder: (
                                                              BuildContext
                                                                  context,
                                                              int index,
                                                            ) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          ManageSmetaBloc>()
                                                                      .add(
                                                                        ChangeEstimatePropertiesEvent(
                                                                          itemId:
                                                                              estimateItem.itemId,
                                                                          unit: state
                                                                              .units[index]
                                                                              .name,
                                                                        ),
                                                                      );
                                                                  setState(
                                                                      () {});
                                                                  context.router
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        9.h,
                                                                    horizontal:
                                                                        16.w,
                                                                  ),
                                                                  decoration: estimateItem
                                                                              .unit ==
                                                                          state
                                                                              .units[index]
                                                                              .name
                                                                      ? ShapeDecoration(
                                                                          color:
                                                                              AppColors.transparent,
                                                                          shape:
                                                                              FancyBorder(
                                                                            shape:
                                                                                const RoundedRectangleBorder(),
                                                                            width:
                                                                                1,
                                                                            gradient:
                                                                                const LinearGradient(
                                                                              colors: [
                                                                                AppColors.gradient1,
                                                                                AppColors.gradient2,
                                                                              ],
                                                                              begin: Alignment.topLeft,
                                                                              end: Alignment.bottomRight,
                                                                            ),
                                                                            corners:
                                                                                BorderRadius.all(Radius.circular(13.r)),
                                                                          ),
                                                                        )
                                                                      : BoxDecoration(
                                                                          color:
                                                                              AppColors.transparent,
                                                                          borderRadius:
                                                                              BorderRadius.circular(13.r),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                AppColors.uiSecondaryBorder,
                                                                          ),
                                                                        ),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        state
                                                                            .units[index]
                                                                            .name,
                                                                        style: AppTypography
                                                                            .subheadsMedium
                                                                            .copyWith(color: AppColors.textPrimary),
                                                                      ),
                                                                      const Spacer(),
                                                                      Container(
                                                                        height:
                                                                            16.h,
                                                                        width:
                                                                            16.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: estimateItem.unit == state.units[index].name
                                                                              ? AppColors.gradient1
                                                                              : AppColors.uiBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(45.r),
                                                                          border:
                                                                              Border.all(
                                                                            color: estimateItem.unit == state.units[index].name
                                                                                ? AppColors.gradient1
                                                                                : AppColors.uiSecondaryBorder,
                                                                          ),
                                                                        ),
                                                                        child: estimateItem.unit ==
                                                                                state.units[index].name
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
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
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
                                                    estimateItem.unit,
                                                    style: AppTypography
                                                        .headlineRegular
                                                        .copyWith(
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  SvgPicture.asset(
                                                    'assets/icons/ic_arrow_down.svg',
                                                    width: 10.5.w,
                                                    height: 6.h,
                                                    colorFilter:
                                                        const ColorFilter.mode(
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
                                    ManageSingleItemWidget(
                                      text: 'Кол-во',
                                      amount: quantity,
                                      metric: 'м²',
                                      onChanged: (value) {
                                        context.read<ManageSmetaBloc>().add(
                                              ChangeEstimatePropertiesEvent(
                                                itemId: estimateItem.itemId,
                                                quantity:
                                                    double.tryParse(value),
                                                clientCost:
                                                    (double.tryParse(value) ??
                                                            0) *
                                                        clientPricePerOne,
                                              ),
                                            );

                                        setState(() {
                                          quantity =
                                              double.tryParse(value) ?? 0;
                                          clientCost =
                                              ((double.tryParse(value) ?? 0) *
                                                  clientPricePerOne);
                                        });
                                      },
                                    ),
                                    ManageSingleItemWidget(
                                      text: 'Цена за 1',
                                      amount: pricePerOne,
                                      metric: '₸',
                                      onChanged: (value) {
                                        double ppOne =
                                            double.tryParse(value) ?? 0;
                                        context.read<ManageSmetaBloc>().add(
                                              ChangeEstimatePropertiesEvent(
                                                itemId: estimateItem.itemId,
                                                pricePerOne: ppOne,
                                                clientPricePerOne: ppOne +
                                                    ((ppOne * percent) / 100),
                                                markup: 100 *
                                                    clientPricePerOne /
                                                    ppOne,
                                              ),
                                            );
                                        setState(() {
                                          pricePerOne = ppOne;
                                          clientPricePerOne = (ppOne +
                                              ((ppOne * percent) / 100));
                                          percent =
                                              (100 * clientPricePerOne / ppOne);
                                        });
                                      },
                                    ),
                                    ManageSingleItemWidget(
                                      text: 'Стоимость',
                                      amount: cost,
                                      metric: '₸',
                                      onChanged: (_) {},
                                      readOnly: true,
                                    ),
                                    ManageSingleItemWidget(
                                      text: 'Наценка, %',
                                      amount: estimateItem.markup,
                                      metric: '%',
                                      onChanged: (value) {
                                        double markup =
                                            double.tryParse(value) ?? 0;

                                        context.read<ManageSmetaBloc>().add(
                                              ChangeEstimatePropertiesEvent(
                                                itemId: estimateItem.itemId,
                                                markup: markup,
                                                clientPricePerOne: pricePerOne +
                                                    ((pricePerOne * markup) /
                                                        100),
                                              ),
                                            );
                                        setState(() {
                                          percent = markup;
                                          clientPricePerOne = (pricePerOne +
                                              ((pricePerOne * markup) / 100));
                                        });
                                      },
                                    ),
                                    ManageSingleItemWidget(
                                      text: 'Цена для заказчика за 1',
                                      amount: clientPricePerOne,
                                      metric: '₸',
                                      onChanged: (value) {
                                        double cppOne =
                                            double.tryParse(value) ?? 0;
                                        context.read<ManageSmetaBloc>().add(
                                              ChangeEstimatePropertiesEvent(
                                                itemId: estimateItem.itemId,
                                                clientPricePerOne: cppOne,
                                                clientCost: quantity * cppOne,
                                                markup:
                                                    100 * cppOne / pricePerOne,
                                              ),
                                            );
                                        setState(() {
                                          clientPricePerOne = cppOne;
                                          clientCost = (quantity * cppOne);
                                          percent =
                                              (100 * cppOne / pricePerOne);
                                        });
                                      },
                                    ),
                                    ManageSingleItemWidget(
                                      readOnly: true,
                                      text: 'Стоимость для заказчика',
                                      amount: clientCost,
                                      metric: '₸',
                                      onChanged: (value) {},
                                    ),
                                    Gap(5.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
        bottomSheet: BlocBuilder<ManageSmetaBloc, ManageSmetaState>(
          builder: (context, state) {
            if (state is ShowManageSmetaState) {
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
                          context.router.push(
                            CreateEstimateItemRoute(
                                estimateId: state.estimateId),
                          );
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
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 495 / 812,
                              minChildSize: 450 / 812,
                              maxChildSize: 500 / 812,
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
                                        'Поделиться',
                                        style: AppTypography.h5Bold.copyWith(
                                            color: AppColors.textPrimary),
                                      ),
                                      Gap(36.h),
                                      IgnorePointer(
                                        ignoring: false,
                                        child: Container(
                                          width: double.infinity,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFF2F4F7), // Light gray background
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: TabBar(
                                            onTap: (int index) {
                                              setState(() {
                                                currentTabIndex = index;
                                              });
                                            },
                                            controller: _tabController,
                                            dividerColor: AppColors.transparent,
                                            tabAlignment: TabAlignment.fill,
                                            labelPadding: EdgeInsets.zero,
                                            indicator: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            tabs: [
                                              Tab(
                                                child: Text(
                                                  'Для меня',
                                                  style: _tabController.index ==
                                                          0
                                                      ? AppTypography
                                                          .subheadsMedium
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textPrimary)
                                                      : AppTypography
                                                          .subheadsRegular
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textSecondary),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  'Для заказчика',
                                                  style: currentTabIndex == 1
                                                      ? AppTypography
                                                          .subheadsMedium
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textPrimary)
                                                      : AppTypography
                                                          .subheadsRegular
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textSecondary),
                                                ),
                                              ),
                                            ],
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            indicatorPadding:
                                                const EdgeInsets.all(4),
                                            labelColor: AppColors.textPrimary,
                                            unselectedLabelColor:
                                                AppColors.textSecondary,
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 348.h,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Gap(16.h),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.uiBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    top: 12.h,
                                                    bottom: 16.h,
                                                    left: 12.w,
                                                    right: 16.w,
                                                  ),
                                                  child: Text(
                                                    'В таблице “Для меня” видна детализация расчетов и установленная наценка. Если вы хотите поделиться сметой с заказчиком, рекомендуем выбрать вкладку “Для заказчика”',
                                                    maxLines: 4,
                                                    style: AppTypography
                                                        .caption1Regular
                                                        .copyWith(
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                  ),
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(19.43.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_printer.svg',
                                                        width: 17.14.w,
                                                        height: 17.14.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(13.43.w),
                                                      Text(
                                                        'Распечатать',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(16.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_excel.svg',
                                                        width: 24.w,
                                                        height: 24.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(10.w),
                                                      Text(
                                                        'Сохранить Excel (XLSX)',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(20.29.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_copy.svg',
                                                        width: 15.43.w,
                                                        height: 17.14.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(14.29.w),
                                                      Text(
                                                        'Создать копию',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(16.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_share.svg',
                                                        width: 24.w,
                                                        height: 24.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(10.w),
                                                      Text(
                                                        'Поделиться',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Gap(16.h),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.uiBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    top: 12.h,
                                                    bottom: 16.h,
                                                    left: 12.w,
                                                    right: 16.w,
                                                  ),
                                                  child: Text(
                                                    'В таблице “Для заказчика” скрыта детализация расчетов и установленная наценка',
                                                    maxLines: 2,
                                                    style: AppTypography
                                                        .caption1Regular
                                                        .copyWith(
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                  ),
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(19.43.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_printer.svg',
                                                        width: 17.14.w,
                                                        height: 17.14.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(13.43.w),
                                                      Text(
                                                        'Распечатать',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(16.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_excel.svg',
                                                        width: 24.w,
                                                        height: 24.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(10.w),
                                                      Text(
                                                        'Сохранить Excel (XLSX)',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(20.29.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_copy.svg',
                                                        width: 15.43.w,
                                                        height: 17.14.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(14.29.w),
                                                      Text(
                                                        'Создать копию',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                                Gap(16.h),
                                                DefaultButtonWidget(
                                                  onTap: () {},
                                                  borderColor: AppColors
                                                      .uiSecondaryBorder,
                                                  backgroundColor:
                                                      AppColors.transparent,
                                                  buttonWidget: Row(
                                                    children: [
                                                      Gap(16.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_share.svg',
                                                        width: 24.w,
                                                        height: 24.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(10.w),
                                                      Text(
                                                        'Поделиться',
                                                        style: AppTypography
                                                            .subheadsMedium
                                                            .copyWith(
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/ic_arrow_right.svg',
                                                        width: 9.w,
                                                        height: 15.75.h,
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          AppColors.textPrimary,
                                                          BlendMode.srcIn,
                                                        ),
                                                      ),
                                                      Gap(15.5.w),
                                                    ],
                                                  ),
                                                  height: 44.h,
                                                  buttonText: '',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
