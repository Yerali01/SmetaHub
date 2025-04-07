import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/single_item_widget.dart';

class CreateSmetaItemWidget extends StatefulWidget {
  const CreateSmetaItemWidget({
    super.key,
  });

  @override
  State<CreateSmetaItemWidget> createState() => _CreateSmetaItemWidgetState();
}

class _CreateSmetaItemWidgetState extends State<CreateSmetaItemWidget> {
  final TextEditingController metricController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // setState(() {
    // metricController.text = widget.estimateItem.unit;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
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
                                    // ListView.separated(
                                    //   padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    //   shrinkWrap: true,
                                    //   separatorBuilder: (context, _) {
                                    //     return Gap(16.h);
                                    //   } ,
                                    //   itemCount: ,
                                    //   itemBuilder: (BuildContext context, int index) {
                                    //     return GestureDetector(
                                    //       onTap: () {
                                    //         // context.read<HomeBloc>().add(
                                    //         //       SelectAiAgentEvent(
                                    //         //         aiAgent:
                                    //         //             state.aiAgents[index],
                                    //         //       ),
                                    //         //     );
                                    //         setState(() {
                                    //           // metricController.clear();
                                    //           // metricController.text = ;
                                    //         });
                                    //         context.router.pop();
                                    //       },
                                    //       child: Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //           vertical: 9.h,
                                    //           horizontal: 16.w,
                                    //         ),
                                    //         decoration: BoxDecoration(
                                    //           color: AppColors.transparent,
                                    //           borderRadius:
                                    //               BorderRadius.circular(13.r),
                                    //           border: Border.all(
                                    //             color:AppColors
                                    //                     .uiSecondaryBorder,
                                    //           ),
                                    //         ),
                                    //         child: Row(
                                    //           children: [
                                    //             Text(
                                    //             'metr',
                                    //               style: AppTypography
                                    //                   .subheadsMedium
                                    //                   .copyWith(
                                    //                       color: AppColors
                                    //                           .textPrimary),
                                    //             ),
                                    //             const Spacer(),
                                    //             Container(
                                    //               height: 16.h,
                                    //               width: 16.w,
                                    //               decoration: BoxDecoration(
                                    //                 color: AppColors
                                    //                         .uiBackground,
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         45.r),
                                    //                 border: Border.all(
                                    //                   color: AppColors
                                    //                       .uiSecondaryBorder,
                                    //                 ),
                                    //               ),
                                    //               // child: isSelected
                                    //               //     ? const Icon(
                                    //               //         Icons.check,
                                    //               //         size: 12,
                                    //               //         color: Colors.white,
                                    //               //       )
                                    //                   // : null,
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   } ,
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: DefaultTextFormField(
                        borderRadius: 8.r,
                        height: 30.h,
                        width: 121.w,
                        showBorder: true,
                        controller: metricController,
                        // isNumber: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 6.h,
                          horizontal: 16.w,
                        ),
                        onChanged: (String value) {},
                        onFieldSubmitted: (String value) {},
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
              ),
              // SingleItemWidget(
              //   text: 'Кол-во',
              //   amount: 0,
              //   metric: 'м²',
              // ),
              // SingleItemWidget(
              //   text: 'Цена за 1',
              //   amount: 0,
              //   metric: '₸',
              // ),
              // SingleItemWidget(
              //   text: 'Стоимость',
              //   amount: 0,
              //   metric: '₸',
              // ),
              // SingleItemWidget(
              //   text: 'Наценка, %',
              //   amount: 0,
              //   metric: '%',
              // ),
              // SingleItemWidget(
              //   text: 'Цена для заказчика за 1',
              //   amount: 0,
              //   metric: '₸',
              // ),
              // SingleItemWidget(
              //   text: 'Стоимость для заказчика',
              //   amount: 0,
              //   metric: '₸',
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
