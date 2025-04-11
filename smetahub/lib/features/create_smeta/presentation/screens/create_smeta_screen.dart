import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/features/create_project/domain/models/project_model.dart';
import 'package:smetahub/features/create_smeta/presentation/bloc/create_smeta_bloc.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/create_smeta_appbar_widget.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/material_button_widget.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/user_projects_widget.dart';
import 'package:smetahub/features/create_smeta/presentation/widgets/work_types_widget.dart';

@RoutePage()
class CreateSmetaScreen extends StatefulWidget {
  const CreateSmetaScreen({super.key});

  @override
  State<CreateSmetaScreen> createState() => _CreateSmetaScreenState();
}

class _CreateSmetaScreenState extends State<CreateSmetaScreen> {
  bool isMissingWork = false;
  bool isMissingMaterial = false;

  // OverlayEntry? _overlayEntry;
  // final LayerLink _layerLink = LayerLink();

  final TextEditingController _specialRequirementsController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.uiBgPanels,
      body: BlocConsumer<CreateSmetaBloc, CreateSmetaState>(
        listener: (BuildContext context, CreateSmetaState state) {
          if (state is ShowCreateSmetaState) {
            // if (state.isEstimateGenerated == false) {
            //   _overlayEntry = OverlayApp().createOverlayGenerateEstimate(
            //     context: context,
            //     layerLink: _layerLink,
            //   );
            //   Overlay.of(context).insert(_overlayEntry!);
            // }
          }
        },
        builder: (BuildContext context, CreateSmetaState state) {
          if (state is ShowCreateSmetaState) {
            if (state.currentPage == 0) {
              final List<ProjectModel> projects = state.projects;

              return Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    ListView(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        left: 15.w,
                        right: 15.w,
                        bottom: 170.h,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const CreateSmetaAppbarWidget(percentage: 0.1),
                        Gap(22.h),
                        Text(
                          'Выберите проект',
                          style: AppTypography.h5Bold
                              .copyWith(color: AppColors.textPrimary),
                          textAlign: TextAlign.center,
                        ),
                        Gap(24.h),
                        SizedBox(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: projects.length,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, _) {
                              return Gap(16.h);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return UserProjectsWidget(
                                project: projects[index],
                                isSelected: state.selectedProject?.name ==
                                    projects[index].name,
                                onTap: () {
                                  context.read<CreateSmetaBloc>().add(
                                        SelectProjectEvent(
                                          project: projects[index],
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        ),
                        Gap(16.h),
                        DefaultButtonWidget(
                          onTap: () {
                            context.router.push(
                              const CreateProjectWrapperRoute(),
                            );
                          },
                          backgroundColor: AppColors.buttonSecondaryBg,
                          buttonText: '',
                          buttonWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Создать новый проект',
                                style: AppTypography.headlineRegular
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                              Gap(5.w),
                              SvgPicture.asset(
                                'assets/icons/ic_plus.svg',
                                width: 13.w,
                                height: 13.h,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.textPrimary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                          textStyle: AppTypography.headlineRegular
                              .copyWith(color: AppColors.textPrimary),
                          borderColor: AppColors.buttonSecondaryBorder,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.uiBgPanels,
                          border: Border.symmetric(
                            horizontal: BorderSide(color: AppColors.uiBorder),
                          ),
                        ),
                        height: 148.h,
                        width: 375.w,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                          top: 8.h,
                        ),
                        child: Column(
                          children: [
                            DefaultButtonWidget(
                              onTap: () {
                                context.read<CreateSmetaBloc>().add(
                                      CreateUserSmetaEvent(
                                        projectId: state.selectedProject?.id,
                                      ),
                                    );
                              },
                              backgroundColor: AppColors.buttonPrimaryBg,
                              buttonText: 'Далее',
                              textStyle: AppTypography.headlineRegular
                                  .copyWith(color: AppColors.buttonPrimaryText),
                            ),
                            Gap(10.h),
                            DefaultButtonWidget(
                              onTap: () {
                                context.read<CreateSmetaBloc>().add(
                                      GetWorkTypesEvent(),
                                    );
                              },
                              backgroundColor: AppColors.buttonSecondaryBg,
                              buttonText: 'Пропустить',
                              textStyle: AppTypography.headlineRegular
                                  .copyWith(color: AppColors.textPrimary),
                              borderColor: AppColors.buttonSecondaryBorder,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.currentPage == 1) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50.h,
                      left: 15.w,
                      right: 15.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CreateSmetaAppbarWidget(percentage: 0.1),
                        Gap(22.h),
                        Text(
                          'Какие виды работ необходимо расчитать?',
                          style: AppTypography.h5Bold
                              .copyWith(color: AppColors.textPrimary),
                          textAlign: TextAlign.center,
                        ),
                        if (isMissingWork) Gap(8.h),
                        if (isMissingWork)
                          Text(
                            'Выберите виды работ',
                            style: AppTypography.caption1Regular
                                .copyWith(color: AppColors.red700),
                          ),
                        Gap(24.h),
                        GestureDetector(
                          onTap: () {
                            context.read<CreateSmetaBloc>().add(
                                  ChooseAllEverythingEvent(),
                                );
                          },
                          child: Row(
                            children: [
                              Gap(7.w),
                              CircleAvatar(
                                radius: 8.r,
                                backgroundColor: AppColors.uiBackground,
                              ),
                              Gap(18.w),
                              Text(
                                'Выбрать все',
                                style: AppTypography.h5Bold
                                    .copyWith(color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                        Gap(21.h),
                        SizedBox(
                          height: 450.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: state.workTypes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return WorkTypesWidget(
                                // icon: projecting[index].icon,
                                icon: 'assets/icons/ic_hammer.svg',
                                title: state.workTypes[index].name,
                                workOptions:
                                    state.workTypes[index].subspeciesWorkTypes,
                                // iconHeight: projecting[index].iconHeight,
                                // iconWidth: projecting[index].iconWidth,
                                iconHeight: 22.h,
                                iconWidth: 24.w,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: AppColors.uiBorder),
                        ),
                      ),
                      height: 148.h,
                      width: 375.w,
                      padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                        top: 8.h,
                      ),
                      child: Column(
                        children: [
                          DefaultButtonWidget(
                            onTap: () {
                              if (state.selectedWorkOptions.isNotEmpty) {
                                context.read<CreateSmetaBloc>().add(
                                      SelectSubspeciesWorkTypeEvent(
                                        subspeciesWorkTypes:
                                            state.selectedWorkOptions,
                                      ),
                                    );
                              } else {
                                setState(() {
                                  isMissingWork = true;
                                });
                              }
                            },
                            backgroundColor: AppColors.buttonPrimaryBg,
                            buttonText: 'Далее',
                            textStyle: AppTypography.headlineRegular
                                .copyWith(color: AppColors.buttonPrimaryText),
                          ),
                          Gap(10.h),
                          DefaultButtonWidget(
                            onTap: () {},
                            backgroundColor: AppColors.buttonSecondaryBg,
                            buttonText: '',
                            buttonWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Подробнее',
                                  style: AppTypography.headlineRegular
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                                Gap(5.h),
                                SvgPicture.asset(
                                  'assets/icons/ic_question.svg',
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.textPrimary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                            textStyle: AppTypography.headlineRegular
                                .copyWith(color: AppColors.textPrimary),
                            borderColor: AppColors.buttonSecondaryBorder,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.currentPage == 2) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50.h,
                      left: 15.w,
                      right: 15.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CreateSmetaAppbarWidget(percentage: 0.4),
                        Gap(22.h),
                        Text(
                          'Выберите тип материалов',
                          style: AppTypography.h5Bold
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        if (isMissingMaterial) Gap(8.h),
                        if (isMissingMaterial)
                          Text(
                            'Выберите тип материалов',
                            style: AppTypography.caption1Regular
                                .copyWith(color: AppColors.red700),
                          ),
                        Gap(24.h),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: state.materialTypes.length,
                          separatorBuilder: (context, _) {
                            return Gap(16.h);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return MaterialButtonWidget(
                              onTap: () {
                                context.read<CreateSmetaBloc>().add(
                                      ChooseMaterialEvent(
                                        material: state.materialTypes[index],
                                      ),
                                    );
                              },
                              text: state.materialTypes[index].name,
                              isSelected: state.selectedMaterial ==
                                  state.materialTypes[index],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: AppColors.uiBorder),
                        ),
                      ),
                      height: 148.h,
                      width: 375.w,
                      padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                        top: 8.h,
                      ),
                      child: Column(
                        children: [
                          DefaultButtonWidget(
                            onTap: () {
                              if (state.selectedMaterial != null) {
                                context.read<CreateSmetaBloc>().add(
                                      AddMaterialTypeEvent(
                                        estimateId: state.estimateId!,
                                        materialTypeId:
                                            state.selectedMaterial!.id,
                                      ),
                                    );
                              } else {
                                setState(() {
                                  isMissingMaterial = true;
                                });
                              }
                            },
                            backgroundColor: AppColors.buttonPrimaryBg,
                            buttonText: 'Далее',
                            textStyle: AppTypography.headlineRegular
                                .copyWith(color: AppColors.buttonPrimaryText),
                          ),
                          Gap(10.h),
                          DefaultButtonWidget(
                            onTap: () {
                              context.read<CreateSmetaBloc>().add(
                                    GoNextPageEvent(),
                                  );
                            },
                            backgroundColor: AppColors.buttonSecondaryBg,
                            buttonText: 'Пропустить',
                            textStyle: AppTypography.headlineRegular
                                .copyWith(color: AppColors.textPrimary),
                            borderColor: AppColors.buttonSecondaryBorder,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.currentPage == 3) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50.h,
                      left: 15.w,
                      right: 15.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CreateSmetaAppbarWidget(percentage: 0.4),
                        Gap(22.h),
                        Text(
                          'Есть ли особые пожелания?',
                          style: AppTypography.h5Bold
                              .copyWith(color: AppColors.textPrimary),
                        ),
                        Gap(24.h),
                        TextFormField(
                          controller: _specialRequirementsController,
                          scrollPadding: EdgeInsets.zero,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Введите особые пожелания',
                            hintStyle: AppTypography.headlineRegular
                                .copyWith(color: AppColors.purple800),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: AppColors.inputBorder,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: AppColors.inputBorder,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                color: AppColors.inputBorder,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.textPrimary,
                          style: AppTypography.subheadsRegular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: AppColors.uiBorder),
                        ),
                      ),
                      height: 92.h,
                      width: 375.w,
                      padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                        top: 8.h,
                      ),
                      child: Column(
                        children: [
                          DefaultButtonWidget(
                            onTap: () {
                              context.read<CreateSmetaBloc>().add(
                                    AddSpecialRequirementsEvent(
                                      text: _specialRequirementsController.text,
                                    ),
                                  );

                              context.read<CreateSmetaBloc>().add(
                                    GenerateEstimateEvent(
                                      estimateId: state.estimateId!,
                                    ),
                                  );
                            },
                            backgroundColor: AppColors.buttonPrimaryBg,
                            buttonText: 'Создать смету',
                            textStyle: AppTypography.headlineRegular
                                .copyWith(color: AppColors.buttonPrimaryText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state.currentPage == 4) {
              return Padding(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 15.w,
                  right: 15.w,
                  bottom: 40.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CreateSmetaAppbarWidget(percentage: 1),
                    Gap(24.h),
                    Lottie.asset(
                      'assets/lotties/create_project_success.json',
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                    Gap(24.h),
                    Text(
                      'Смета успешно сформирована!\nКак назвать смету?',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                    Gap(32.h),
                    TextFormField(
                      scrollPadding: EdgeInsets.zero,
                      controller: _nameController,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: 'Введите название сметы',
                        hintStyle: AppTypography.headlineRegular
                            .copyWith(color: AppColors.purple800),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.inputBorder,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.inputBorder,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(
                            color: AppColors.inputBorder,
                          ),
                        ),
                      ),
                      cursorColor: AppColors.textPrimary,
                      style: AppTypography.subheadsRegular.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        DefaultButtonWidget(
                          onTap: () {
                            context.read<CreateSmetaBloc>().add(
                                  CreateSmetaNameEvent(
                                    name: _nameController.text,
                                  ),
                                );
                            // context.router
                            //     .navigate(ManageSmetaWrapperRoute(
                            //       estimateId:
                            //     ));
                          },
                          backgroundColor: AppColors.buttonPrimaryBg,
                          buttonText: 'Открыть смету',
                          textStyle: AppTypography.headlineRegular
                              .copyWith(color: AppColors.buttonPrimaryText),
                        ),
                        Gap(10.h),
                        DefaultButtonWidget(
                          onTap: () {
                            context.read<CreateSmetaBloc>().add(
                                  CreateSmetaNameEvent(
                                    name: _nameController.text,
                                  ),
                                );
                            context.router.navigate(const HomeWrapperRoute());
                          },
                          backgroundColor: AppColors.buttonSecondaryBg,
                          buttonText: 'Вернуться на главную',
                          textStyle: AppTypography.headlineRegular
                              .copyWith(color: AppColors.textPrimary),
                          borderColor: AppColors.buttonSecondaryBorder,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
