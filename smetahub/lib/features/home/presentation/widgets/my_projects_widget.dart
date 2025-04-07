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

// class MyProjectsWidget extends StatelessWidget {
//   const MyProjectsWidget({super.key});

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
//                       'Мои проекты',
//                       style: AppTypography.headlineMedium.copyWith(
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
//                     const Spacer(),
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             context.router
//                                 .push(const CreateProjectWrapperRoute());
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.r),
//                               color: AppColors.gray300A18,
//                             ),
//                             height: 20.h,
//                             padding: EdgeInsets.only(
//                               top: 2.h,
//                               bottom: 2.h,
//                               left: 8.w,
//                               right: 2.w,
//                             ),
//                             child: Center(
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'Создать',
//                                     style:
//                                         AppTypography.caption1Regular.copyWith(
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                   Gap(4.w),
//                                   SvgPicture.asset(
//                                     'assets/icons/ic_add.svg',
//                                     width: 10.w,
//                                     height: 10.h,
//                                     colorFilter: const ColorFilter.mode(
//                                       AppColors.textPrimary,
//                                       BlendMode.srcIn,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Gap(8.w),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.r),
//                             color: AppColors.gray300A18,
//                           ),
//                           height: 20.h,
//                           padding: EdgeInsets.only(
//                             top: 2.h,
//                             bottom: 2.h,
//                             left: 8.w,
//                             right: 2.w,
//                           ),
//                           child: Center(
//                             child: Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     context.router.push(
//                                       const AllProjectsRoute(),
//                                     );
//                                   },
//                                   child: Text(
//                                     'Все ${state.projects.length}',
//                                     style:
//                                         AppTypography.caption1Regular.copyWith(
//                                       color: AppColors.textPrimary,
//                                     ),
//                                   ),
//                                 ),
//                                 Gap(4.w),
//                                 SvgPicture.asset(
//                                   'assets/icons/ic_arrow_right.svg',
//                                   width: 6.w,
//                                   height: 10.5.h,
//                                   colorFilter: const ColorFilter.mode(
//                                     AppColors.textPrimary,
//                                     BlendMode.srcIn,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Gap(14.h),
//               if (state.projects.isNotEmpty)
//                 SizedBox(
//                   height: 111.h,
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.symmetric(horizontal: 15.w),
//                     scrollDirection: Axis.horizontal,
//                     itemCount: state.projects.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 10.5.h,
//                           horizontal: 8.w,
//                         ).copyWith(
//                           right: 12.w,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.uiBgPanels,
//                           borderRadius: BorderRadius.circular(14.r),
//                         ),
//                         height: 111.h,
//                         width: 219.w,
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 50.w,
//                               height: 88.h,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.r),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.r),
//                                 child: state.projects[index].files != null &&
//                                         state.projects[index].files!.isNotEmpty
//                                     ? Image.network(
//                                         state.projects[index].files?.first
//                                             .downloadUrl,
//                                         width: 50.w,
//                                         height: 88.h,
//                                         fit: BoxFit.cover,
//                                       )
//                                     : Image.asset(
//                                         'assets/images/no_photo.png',
//                                         width: 50.w,
//                                         height: 88.h,
//                                         fit: BoxFit.cover,
//                                       ),
//                               ),
//                             ),
//                             Gap(6.w),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       'assets/icons/ic_location_marker.svg',
//                                       width: 12.w,
//                                       height: 12.h,
//                                       colorFilter: const ColorFilter.mode(
//                                         AppColors.textPrimary,
//                                         BlendMode.srcIn,
//                                       ),
//                                     ),
//                                     Gap(2.w),
//                                     SizedBox(
//                                       width: 129.w,
//                                       child: Text(
//                                         state.projects[index].name ?? '',
//                                         style: AppTypography.caption1Medium
//                                             .copyWith(
//                                           color: AppColors.textPrimary,
//                                         ),
//                                         softWrap: true,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Gap(6.h),
//                                 SizedBox(
//                                   height: 19.h,
//                                   width: 100.w,
//                                   child: Stack(
//                                     children: [
//                                       for (int i = 0;
//                                           i <
//                                               (state.projects[index].aiAgents
//                                                       ?.length ??
//                                                   0);
//                                           i++)
//                                         Positioned(
//                                           left: i * 16,
//                                           child: CircleAvatar(
//                                             radius: 10.5,
//                                             backgroundColor: Colors.white,
//                                             child: state.projects[index]
//                                                         .aiAgents?[i].image !=
//                                                     null
//                                                 ? Center(
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               33.r),
//                                                       child: Image.network(
//                                                         width: 19.w,
//                                                         height: 19.h,
//                                                         state
//                                                             .projects[index]
//                                                             .aiAgents?[i]
//                                                             .image!,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : null,
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                                 // Gap(6.h),
//                                 // const ContainerTextWidget(
//                                 //   bgColor: AppColors.purple300A18,
//                                 //   text: 'супер цена',
//                                 // ),
//                                 Gap(6.h),
//                                 ContainerTextWidget(
//                                   bgColor: AppColors.blue700A18,
//                                   text: '',
//                                   childWidget: Row(
//                                     children: [
//                                       SvgPicture.asset(
//                                         'assets/icons/ic_paper_list.svg',
//                                         width: 12.w,
//                                         height: 12.h,
//                                         colorFilter: const ColorFilter.mode(
//                                           AppColors.blue700,
//                                           BlendMode.srcIn,
//                                         ),
//                                       ),
//                                       Gap(4.w),
//                                       Text(
//                                         '${state.projects[index].status}',
//                                         style: AppTypography.caption1Regular
//                                             .copyWith(
//                                           color: AppColors.blue700,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return Gap(12.h);
//                     },
//                   ),
//                 ),
//               if (state.projects.isEmpty)
//                 GestureDetector(
//                   onTap: () {
//                     context.router.push(const CreateProjectWrapperRoute());
//                   },
//                   child: Container(
//                     height: 111.h,
//                     width: 219.w,
//                     margin: EdgeInsets.only(left: 15.w),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14.r),
//                       color: AppColors.uiBgPanels,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 26.r,
//                           backgroundColor: AppColors.uiBackground,
//                           child: Center(
//                             child: SvgPicture.asset(
//                               'assets/icons/ic_add.svg',
//                               width: 21.w,
//                               height: 21.h,
//                               colorFilter: const ColorFilter.mode(
//                                 AppColors.textSecondary,
//                                 BlendMode.srcIn,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Gap(8.h),
//                         Text(
//                           'Создать проект',
//                           style: AppTypography.caption1Medium.copyWith(
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         }
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
