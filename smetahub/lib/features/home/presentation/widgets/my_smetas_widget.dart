// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:smetahub/core/services/router/app_router.dart';
// import 'package:smetahub/core/utils/app_typography.dart';
// import 'package:smetahub/core/utils/colors.dart';
// import 'package:smetahub/features/create_smeta/presentation/widgets/container_text_widget.dart';
// import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';

// class MySmetasWidget extends StatelessWidget {
//   const MySmetasWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeBloc, HomeState>(
//       listener: (BuildContext context, HomeState state) {},
//       builder: (BuildContext context, HomeState state) {
//         if (state is ShowHomeState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15.w),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Мои сметы',
//                       style: AppTypography.headlineMedium.copyWith(
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         context.router.push(const CreateSmetaWrapperRoute());
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.r),
//                           color: AppColors.gray300A18,
//                         ),
//                         height: 20.h,
//                         padding: EdgeInsets.only(
//                           top: 2.h,
//                           bottom: 2.h,
//                           left: 8.w,
//                           right: 2.w,
//                         ),
//                         child: Center(
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Создать',
//                                 style: AppTypography.caption1Regular.copyWith(
//                                   color: AppColors.textPrimary,
//                                 ),
//                               ),
//                               Gap(4.w),
//                               SvgPicture.asset(
//                                 'assets/icons/ic_add.svg',
//                                 width: 10.w,
//                                 height: 10.h,
//                                 colorFilter: const ColorFilter.mode(
//                                   AppColors.textPrimary,
//                                   BlendMode.srcIn,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Gap(8.w),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.r),
//                         color: AppColors.gray300A18,
//                       ),
//                       height: 20.h,
//                       padding: EdgeInsets.only(
//                         top: 2.h,
//                         bottom: 2.h,
//                         left: 8.w,
//                         right: 2.w,
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {},
//                               child: Text(
//                                 'Все ${state.userEstimates.length}',
//                                 style: AppTypography.caption1Regular.copyWith(
//                                   color: AppColors.textPrimary,
//                                 ),
//                               ),
//                             ),
//                             Gap(4.w),
//                             SvgPicture.asset(
//                               'assets/icons/ic_arrow_right.svg',
//                               width: 6.w,
//                               height: 10.5.h,
//                               colorFilter: const ColorFilter.mode(
//                                 AppColors.textPrimary,
//                                 BlendMode.srcIn,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Gap(14.h),
//               state.userEstimates.isNotEmpty
//                   ? ListView.separated(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
//                         bottom: 200.h,
//                       ),
//                       itemCount: state.userEstimates.length,
//                       separatorBuilder: (BuildContext context, _) {
//                         return Gap(14.h);
//                       },
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             context.router.push(
//                               ManageSmetaWrapperRoute(
//                                 estimateId: state.userEstimates[index].id,
//                               ),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.uiBgPanels,
//                               borderRadius: BorderRadius.circular(14.r),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               vertical: 8.h,
//                               horizontal: 10.w,
//                             ).copyWith(
//                               right: 16.w,
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 12.r,
//                                       backgroundColor: AppColors.purple300A18,
//                                       child: Center(
//                                         child: SvgPicture.asset(
//                                           'assets/icons/ic_paper_list.svg',
//                                           width: 9.5.w,
//                                           height: 11.66.h,
//                                           colorFilter: const ColorFilter.mode(
//                                             AppColors.textPrimary,
//                                             BlendMode.srcIn,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Gap(8.w),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       '${state.userEstimates[index].name}',
//                                       style:
//                                           AppTypography.subheadsMedium.copyWith(
//                                         color: AppColors.textPrimary,
//                                       ),
//                                       maxLines: 1,
//                                       softWrap: true,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Gap(6.h),
//                                     ContainerTextWidget(
//                                       bgColor: AppColors.purple300A18,
//                                       text: 'text',
//                                       textStyle:
//                                           AppTypography.caption1Medium.copyWith(
//                                         color: AppColors.textPrimary,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : GestureDetector(
//                       onTap: () {
//                         context.router.push(const CreateSmetaWrapperRoute());
//                       },
//                       child: Container(
//                         height: 56.h,
//                         width: 345.w,
//                         margin: EdgeInsets.only(left: 15.w),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(14.r),
//                           color: AppColors.uiBgPanels,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Gap(10.w),
//                             CircleAvatar(
//                               radius: 12.r,
//                               backgroundColor: AppColors.uiBackground,
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   'assets/icons/ic_add.svg',
//                                   width: 16.w,
//                                   height: 16.h,
//                                   colorFilter: const ColorFilter.mode(
//                                     AppColors.textSecondary,
//                                     BlendMode.srcIn,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Gap(8.h),
//                             Text(
//                               'Создать смету',
//                               style: AppTypography.caption1Medium.copyWith(
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//             ],
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
