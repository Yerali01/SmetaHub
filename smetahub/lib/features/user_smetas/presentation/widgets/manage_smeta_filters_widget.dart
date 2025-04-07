import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc.dart';
import 'package:smetahub/features/user_smetas/presentation/widgets/filter_buttons_widget.dart';

class ManageSmetaFiltersWidget extends StatelessWidget {
  const ManageSmetaFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                          );
                        },
                      ),
                    );
                  },
                  iconPath: 'assets/icons/ic_sort.svg',
                  iconHeight: 9.55.h,
                  iconWidth: 11.41.w,
                  text: 'Сортировать',
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
