// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:smetahub/core/utils/app_typography.dart';
// import 'package:smetahub/core/utils/colors.dart';
// import 'package:smetahub/features/create_project/presentation/bloc/create_project_bloc.dart';

// class PickedImagesWidget extends StatelessWidget {
//   const PickedImagesWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CreateProjectBloc, CreateProjectState>(
//       listener: (BuildContext context, CreateProjectState state) {},
//       builder: (BuildContext context, CreateProjectState state) {
//         if (state is ShowCreateProjectState) {
//           log('PICKED IMAGES ${state.pickedImages}');
//           return ListView.separated(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             itemCount: state.pickedImages.length,
//             separatorBuilder: (context, _) {
//               return Gap(18.h);
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return SizedBox(
//                 height: 41.h,
//                 child: Row(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.uiBorder,
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       height: 40.h,
//                       width: 40.w,
//                       child: Center(
//                         child: SvgPicture.asset(
//                           'assets/icons/ic_picture.svg',
//                           width: 18.w,
//                           height: 18.h,
//                           colorFilter: const ColorFilter.mode(
//                             AppColors.textPrimary,
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Gap(10.w),
//                     SizedBox(
//                       width: 270.w,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             state.pickedImages[index].name,
//                             style: AppTypography.headlineMedium.copyWith(
//                               color: AppColors.textPrimary,
//                             ),
//                             softWrap: true,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Gap(6.h),
//                           Row(
//                             children: [
//                               Text(
//                                 '${state.pickedImages[index].path.length} KB',
//                                 style: AppTypography.subheadsRegular.copyWith(
//                                   color: AppColors.textSecondary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         int id =
//                             state.uploadedFilesAndImagesIDs.where((int item) {
//                               return item.
//                             });
//                         context.read<CreateProjectBloc>().add(
//                               DeleteFileEvent(
//                                 fileId: id,
//                                 isImage: true,
//                                 isFile: false,
//                                 fileName: state.pickedImages[index].name,
//                               ),
//                             );
//                       },
//                       child: SvgPicture.asset(
//                         'assets/icons/ic_trash.svg',
//                         width: 18.w,
//                         height: 21.h,
//                         colorFilter: const ColorFilter.mode(
//                           AppColors.red700,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
