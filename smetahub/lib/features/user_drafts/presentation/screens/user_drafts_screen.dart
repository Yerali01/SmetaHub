import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/user_drafts/presentation/bloc/user_drafts_bloc.dart';
import 'package:smetahub/features/user_drafts/presentation/widgets/user_drafts_appbar_widget.dart';

@RoutePage()
class UserDraftsScreen extends StatelessWidget {
  const UserDraftsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.uiBgPanels,
      body: BlocConsumer<UserDraftsBloc, UserDraftsState>(
        listener: (BuildContext context, UserDraftsState state) {
          // TODO: implement listener
        },
        builder: (BuildContext context, UserDraftsState state) {
          if (state is ShowUserDraftsState) {
            return SizedBox(
              height: deviceHeight,
              child: ListView(
                padding: EdgeInsets.only(
                  top: 50.h,
                ),
                children: [
                  const UserDraftsAppbarWidget(),
                  Gap(25.h),
                  Container(
                    width: deviceWidth,
                    height: 1.h,
                    color: AppColors.uiBorder,
                  ),
                  Gap(16.h),
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
