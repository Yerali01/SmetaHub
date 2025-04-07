import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/ai_chat/presentation/widgets/default_icon_button_widget.dart';

class UserDraftsAppbarWidget extends StatelessWidget {
  const UserDraftsAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.router.navigate(const HomeWrapperRoute());
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_arrow_left.svg',
                  width: 6.w,
                  height: 11.h,
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(7, 12, 43, 1),
                    BlendMode.srcIn,
                  ),
                ),
                Gap(5.w),
                Text(
                  'Назад',
                  style: AppTypography.caption1Regular
                      .copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          Text(
            'Черновики',
            style: AppTypography.headlineRegular
                .copyWith(color: AppColors.textPrimary),
          ),
          GestureDetector(
            onTap: () {},
            child: DefaultIconButtonWidget(
              icon: 'assets/icons/ic_select_all.svg',
              iconWidth: 17.14.w,
              iconHeight: 17.14.h,
            ),
          ),
        ],
      ),
    );
  }
}
