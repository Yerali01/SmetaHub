import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/utils/overlay_app.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/container_text_widget.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';
import 'package:smetahub/features/home/presentation/widgets/ai_consultants_widget.dart';
import 'package:smetahub/features/home/presentation/widgets/home_appbar_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    OverlayEntry? _overlayEntry;
    final LayerLink _layerLink = LayerLink();

    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {
          if (state is CreateChatSuccessState) {
            context.router.push(
              AiChatWrapperRoute(
                chatId: state.chatId,
                agentId: state.agentId,
                userInitialText: chatController.text,
              ),
            );
          }
        },
        builder: (BuildContext context, HomeState state) {
          if (state is ShowHomeState) {
            return SizedBox(
              width: deviceWidth,
              height: deviceHeight,
              child: Stack(
                children: [
                  Container(
                    color: AppColors.uiBackground,
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Gap(54.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: const HomeScreenAppBarWidget(),
                      ),
                      Gap(32.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              children: [
                                Text(
                                  'Мои проекты',
                                  style: AppTypography.headlineMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        List<ProjectModel> draftProjects = state
                                            .projects
                                            .where((ProjectModel proj) {
                                          return proj.status == 'draft';
                                        }).toList();

                                        if (draftProjects.isNotEmpty) {
                                          _overlayEntry = OverlayApp()
                                              .createOverlayDraftProjects(
                                            context: context,
                                            layerLink: _layerLink,
                                            removeOverlay: () {
                                              _overlayEntry!.remove();
                                            },
                                            noClick: () {
                                              _overlayEntry!.remove();

                                              context.router.push(
                                                const CreateProjectWrapperRoute(),
                                              );
                                            },
                                            yesClick: () {
                                              _overlayEntry!.remove();
                                              context.router.push(
                                                const UserDraftsWrapperRoute(),
                                              );
                                            },
                                          );
                                          Overlay.of(context)
                                              .insert(_overlayEntry!);
                                        } else {
                                          context.router.push(
                                            const CreateProjectWrapperRoute(),
                                          );
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.gray300A18,
                                        ),
                                        height: 20.h,
                                        padding: EdgeInsets.only(
                                          top: 2.h,
                                          bottom: 2.h,
                                          left: 8.w,
                                          right: 2.w,
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                'Создать',
                                                style: AppTypography
                                                    .caption1Regular
                                                    .copyWith(
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              Gap(4.w),
                                              SvgPicture.asset(
                                                'assets/icons/ic_add.svg',
                                                width: 10.w,
                                                height: 10.h,
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
                                    ),
                                    Gap(8.w),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColors.gray300A18,
                                      ),
                                      height: 20.h,
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        bottom: 2.h,
                                        left: 8.w,
                                        right: 2.w,
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                context.router.push(
                                                  const AllProjectsRoute(),
                                                );
                                              },
                                              child: Text(
                                                'Все ${state.projects.length}',
                                                style: AppTypography
                                                    .caption1Regular
                                                    .copyWith(
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                            Gap(4.w),
                                            SvgPicture.asset(
                                              'assets/icons/ic_arrow_right.svg',
                                              width: 6.w,
                                              height: 10.5.h,
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
                              ],
                            ),
                          ),
                          Gap(14.h),
                          if (state.projects.isNotEmpty)
                            SizedBox(
                              height: 111.h,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.projects.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10.5.h,
                                      horizontal: 8.w,
                                    ).copyWith(
                                      right: 12.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.uiBgPanels,
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    height: 111.h,
                                    width: 219.w,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50.w,
                                          height: 88.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child:
                                                state.projects[index].files !=
                                                            null &&
                                                        state.projects[index]
                                                            .files!.isNotEmpty
                                                    ? Image.network(
                                                        state
                                                            .projects[index]
                                                            .files
                                                            ?.first
                                                            .downloadUrl,
                                                        width: 50.w,
                                                        height: 88.h,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        'assets/images/no_photo.png',
                                                        width: 50.w,
                                                        height: 88.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                          ),
                                        ),
                                        Gap(6.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/ic_location_marker.svg',
                                                  width: 12.w,
                                                  height: 12.h,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    AppColors.textPrimary,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                                Gap(2.w),
                                                SizedBox(
                                                  width: 129.w,
                                                  child: Text(
                                                    state.projects[index]
                                                            .name ??
                                                        '',
                                                    style: AppTypography
                                                        .caption1Medium
                                                        .copyWith(
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(6.h),
                                            SizedBox(
                                              height: 19.h,
                                              width: 100.w,
                                              child: Stack(
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          (state
                                                                  .projects[
                                                                      index]
                                                                  .aiAgents
                                                                  ?.length ??
                                                              0);
                                                      i++)
                                                    Positioned(
                                                      left: i * 16,
                                                      child: CircleAvatar(
                                                        radius: 10.5,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: state
                                                                    .projects[
                                                                        index]
                                                                    .aiAgents?[
                                                                        i]
                                                                    .image !=
                                                                null
                                                            ? Center(
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              33.r),
                                                                  child: Image
                                                                      .network(
                                                                    width: 19.w,
                                                                    height:
                                                                        19.h,
                                                                    state
                                                                        .projects[
                                                                            index]
                                                                        .aiAgents?[
                                                                            i]
                                                                        .image!,
                                                                  ),
                                                                ),
                                                              )
                                                            : null,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            // Gap(6.h),
                                            // const ContainerTextWidget(
                                            //   bgColor: AppColors.purple300A18,
                                            //   text: 'супер цена',
                                            // ),
                                            Gap(6.h),
                                            ContainerTextWidget(
                                              bgColor: AppColors.blue700A18,
                                              text: '',
                                              childWidget: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/ic_paper_list.svg',
                                                    width: 12.w,
                                                    height: 12.h,
                                                    colorFilter:
                                                        const ColorFilter.mode(
                                                      AppColors.blue700,
                                                      BlendMode.srcIn,
                                                    ),
                                                  ),
                                                  Gap(4.w),
                                                  Text(
                                                    '${state.projects[index].status}',
                                                    style: AppTypography
                                                        .caption1Regular
                                                        .copyWith(
                                                      color: AppColors.blue700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Gap(12.h);
                                },
                              ),
                            ),
                          if (state.projects.isEmpty)
                            GestureDetector(
                              onTap: () {
                                context.router
                                    .push(const CreateProjectWrapperRoute());
                              },
                              child: Container(
                                height: 111.h,
                                width: 219.w,
                                margin: EdgeInsets.only(left: 15.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.r),
                                  color: AppColors.uiBgPanels,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 26.r,
                                      backgroundColor: AppColors.uiBackground,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/icons/ic_add.svg',
                                          width: 21.w,
                                          height: 21.h,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.textSecondary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(8.h),
                                    Text(
                                      'Создать проект',
                                      style:
                                          AppTypography.caption1Medium.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      Gap(32.h),
                      const AiConsultantsWidget(),
                      Gap(32.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Row(
                              children: [
                                Text(
                                  'Мои сметы',
                                  style: AppTypography.headlineMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    context.router
                                        .push(const CreateSmetaWrapperRoute());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColors.gray300A18,
                                    ),
                                    height: 20.h,
                                    padding: EdgeInsets.only(
                                      top: 2.h,
                                      bottom: 2.h,
                                      left: 8.w,
                                      right: 2.w,
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Создать',
                                            style: AppTypography.caption1Regular
                                                .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          Gap(4.w),
                                          SvgPicture.asset(
                                            'assets/icons/ic_add.svg',
                                            width: 10.w,
                                            height: 10.h,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.textPrimary,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(8.w),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.gray300A18,
                                  ),
                                  height: 20.h,
                                  padding: EdgeInsets.only(
                                    top: 2.h,
                                    bottom: 2.h,
                                    left: 8.w,
                                    right: 2.w,
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            'Все ${state.userEstimates.length}',
                                            style: AppTypography.caption1Regular
                                                .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                        Gap(4.w),
                                        SvgPicture.asset(
                                          'assets/icons/ic_arrow_right.svg',
                                          width: 6.w,
                                          height: 10.5.h,
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
                          Gap(14.h),
                          state.userEstimates.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w)
                                          .copyWith(
                                    bottom: 200.h,
                                  ),
                                  itemCount: state.userEstimates.length,
                                  separatorBuilder: (BuildContext context, _) {
                                    return Gap(14.h);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.router.push(
                                          ManageSmetaWrapperRoute(
                                            estimateId:
                                                state.userEstimates[index].id,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.uiBgPanels,
                                          borderRadius:
                                              BorderRadius.circular(14.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 10.w,
                                        ).copyWith(
                                          right: 16.w,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 12.r,
                                                  backgroundColor:
                                                      AppColors.purple300A18,
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      'assets/icons/ic_paper_list.svg',
                                                      width: 9.5.w,
                                                      height: 11.66.h,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        AppColors.textPrimary,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(8.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${state.userEstimates[index].name}',
                                                  style: AppTypography
                                                      .subheadsMedium
                                                      .copyWith(
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Gap(6.h),
                                                ContainerTextWidget(
                                                  bgColor:
                                                      AppColors.purple300A18,
                                                  text: 'text',
                                                  textStyle: AppTypography
                                                      .caption1Medium
                                                      .copyWith(
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : GestureDetector(
                                  onTap: () {
                                    context.router
                                        .push(const CreateSmetaWrapperRoute());
                                  },
                                  child: Container(
                                    height: 56.h,
                                    width: 345.w,
                                    margin: EdgeInsets.only(left: 15.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.r),
                                      color: AppColors.uiBgPanels,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Gap(10.w),
                                        CircleAvatar(
                                          radius: 12.r,
                                          backgroundColor:
                                              AppColors.uiBackground,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/icons/ic_add.svg',
                                              width: 16.w,
                                              height: 16.h,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                AppColors.textSecondary,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Gap(8.h),
                                        Text(
                                          'Создать смету',
                                          style: AppTypography.caption1Medium
                                              .copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
      bottomSheet: BlocConsumer<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is ShowHomeState) {
            return Container(
              width: deviceWidth,
              height: 170.h,
              decoration: BoxDecoration(
                color: AppColors.uiBgPanels,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blue232660.withOpacity(0.14),
                    blurRadius: 42.8.r,
                    offset: const Offset(0, -7),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                bottom: 40.h,
                top: 20.h,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_consultant_star.svg',
                        width: 16.w,
                        height: 16.h,
                      ),
                      Gap(6.w),
                      SizedBox(
                        width: 323.w,
                        child: TextFormField(
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          controller: chatController,
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Введите, скажите или отправьте файл...',
                            hintMaxLines: 1,
                            hintStyle: AppTypography.headlineRegular.copyWith(
                              color: AppColors.gray100,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(8.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 0.7,
                              minChildSize: 0.4,
                              maxChildSize: 0.9,
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
                                        'Выберите ИИ консультанта',
                                        style: AppTypography.h5Bold.copyWith(
                                            color: AppColors.textPrimary),
                                      ),
                                      Gap(36.h),
                                      ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: state.aiAgents.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Gap(16.h);
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          bool isSelected =
                                              state.selectedAiAgent?.id ==
                                                  state.aiAgents[index].id;
                                          return GestureDetector(
                                            onTap: () {
                                              context.read<HomeBloc>().add(
                                                    SelectAiAgentEvent(
                                                      aiAgent:
                                                          state.aiAgents[index],
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
                                              decoration: BoxDecoration(
                                                color: AppColors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(13.r),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? AppColors.gradient1
                                                      : AppColors
                                                          .uiSecondaryBorder,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 13.r,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              38.r),
                                                      child: Image.network(
                                                        state.aiAgents[index]
                                                                .image ??
                                                            '',
                                                        width: 26.w,
                                                        height: 26.h,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Gap(8.w),
                                                  Text(
                                                    state.aiAgents[index].name,
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
                                                        color: AppColors
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
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: AppColors.gray300A18,
                            borderRadius: BorderRadius.circular(22.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 7.5.h,
                          ).copyWith(
                            right: 10.w,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(49.r),
                                child: state.selectedAiAgent?.image != null
                                    ? Image.network(
                                        state.selectedAiAgent!.image!,
                                        width: 20.w,
                                        height: 20.h,
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              Gap(8.w),
                              Text(
                                'Чат с "${state.selectedAiAgent?.name}"',
                                style: AppTypography.subheadsMedium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(6.w),
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
                      const Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 34.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                            color: AppColors.buttonPrimaryBg,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/ic_paper_clip.svg',
                              width: 21.w,
                              height: 18.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.buttonPrimaryText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(8.w),
                      chatController.text.isEmpty
                          ? GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 34.w,
                                height: 34.h,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonPrimaryBg,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_microphone.svg',
                                    width: 14.w,
                                    height: 18.h,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.buttonPrimaryText,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                context.read<HomeBloc>().add(
                                      CreateChatEvent(
                                        title: chatController.text,
                                        aiAgentId: state.selectedAiAgent!.id,
                                      ),
                                    );
                              },
                              child: Container(
                                width: 34.w,
                                height: 34.h,
                                decoration: BoxDecoration(
                                  color: AppColors.buttonPrimaryBg,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_send_message.svg',
                                    width: 20.w,
                                    height: 20.h,
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
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
        listener: (BuildContext context, HomeState state) {},
      ),
    );
  }
}
