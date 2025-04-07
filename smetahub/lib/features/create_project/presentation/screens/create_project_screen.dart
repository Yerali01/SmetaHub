import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/bottom_sheets.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_button_widget.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';
import 'package:smetahub/features/create_project/domain/models/object_condition_model.dart';
import 'package:smetahub/features/create_project/domain/models/object_type_model.dart';
import 'package:smetahub/features/create_project/domain/models/project_category_model.dart';
import 'package:smetahub/features/create_project/presentation/bloc/create_project_bloc.dart';
import 'package:smetahub/features/create_project/presentation/widgets/category_button_widget.dart';
import 'package:smetahub/features/create_project/presentation/widgets/create_project_appbar_widget.dart';
import 'package:smetahub/features/create_project/presentation/widgets/current_state_card_widget.dart';
import 'package:smetahub/features/create_project/presentation/widgets/picked_files_widget.dart';
import 'package:smetahub/features/create_project/presentation/widgets/project_card_widget.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';

@RoutePage()
class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final List<String> fileTypes = [
    'png',
    'jpg',
    'svg',
    'txt',
    'pdf',
    'docx',
    'xlsx',
    'csv',
  ];

  /// bottom sheet variables ---------------------------------------------------------------------------------

  final List<List<String>> objectTypeInfo = [
    [
      'Частный дом',
      'Это отдельное здание, предназначенное для проживания одной или нескольких семей. Обычно имеет свою территорию и может включать несколько этажей.'
    ],
    [
      'Квартира',
      'Это отдельное жилое помещение в многоквартирном доме, предназначенное для проживания. Квартиры часто имеют общие стены с соседними квартирами и могут располагаться на разных этажах здания.'
    ],
    [
      'Коммерческое помещение',
      'Это пространство, предназначенное для ведения бизнеса и коммерческой деятельности. Например офисы, магазины, рестораны, склады и т.д.'
    ],
    [
      'Общественное здание',
      'Это здание, предназначенное для общественного использования. Такие здания включают школы, больницы, библиотеки и административные здания.'
    ],
    [
      'Специальный объект',
      'Это здание или помещение, предназначенное для выполнения специфических задач или функций, таких как лаборатории, военные объекты или производственные цеха. Обычно имеет особые требования к строительству и эксплуатации.'
    ],
  ];

  final List<List<String>> categoryInfo = [
    [
      'Новостройка',
      'Это новое жилье или объект недвижимости, недавно построенное или еще не заселённое.'
    ],
    [
      'Вторичное жилье',
      'Это жилье или объект недвижимости, которое уже использовалось или было заселено ранее.'
    ],
  ];

  final List<List<String>> currentStateInfo = [
    [
      'Без отделки',
      'Это самая базовая стадия, где стены и потолки остаются в первоначальном состоянии (бетон или кирпич). Полы также без покрытия, зачастую только бетонная стяжка. Инженерные системы находятся на минимальном уровне - возможно только первичная электропроводка.'
    ],
    [
      'Черновая отделка',
      'Стены и потолки оштукатурены и зашпаклеваны, готовые к дальнейшей отделке. Полы выравнены. Проложены коммуникации - трубы водопровода, канализации, электропроводка, возможно установка радиаторов.'
    ],
    [
      'Предчистовая отделка',
      'Стены и потолки грунтованы и готовы для нанесения финишной отделки (покраски или обоев). Полы выравнены, возможна гидроизоляция. Инженерные системы полностью проложены и готовы к подключению оборудования, установки сантехники.'
    ],
    [
      'Чистовая отделка',
      'Помещение полностью готово к заселению. Стены и потолки покрашены или покрыты обоями. Полы полностью покрыты (ламинат, паркет, плитка и т.д.). Все инженерные системы подключены и функционируют. Установлены светильники, сантехника, кухонное оборудование и прочие элементы интерьера.'
    ],
  ];

  /// --------------------------------------------------------------------------------------------------------

  TextEditingController projectName = TextEditingController();
  String? objectType;

  int? objectTypeId;
  String? objectName;
  String? objectImage;

  String? category;
  int? projectCategoryId;
  String? categoryName;
  String? currentStateItem;
  int? objectConditionId;
  String? objectConditionName;
  String? objectConditionImage;

  TextEditingController totalArea = TextEditingController();

  List<AiConsultant> selectedAiConsultants = [];

  bool isNameEmpty = false;
  bool isAreaEmpty = false;
  bool missingObjectType = false;
  bool missingCategory = false;
  bool missingCurrentState = false;
  bool missingFiles = false;
  bool missingAiConsultants = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.uiBgPanels,
      body: BlocConsumer<CreateProjectBloc, CreateProjectState>(
        listener: (BuildContext context, CreateProjectState state) {
          if (state is ShowCreateProjectState) {
            if (state.isOpenObjectBottomSheet) {
              BottomSheetUtils().showCreateProjectInfoSheet(
                context: context,
                title: 'Подробнее о типах объекта',
                height: 658.h,
                mainInformation: objectTypeInfo,
                removeOverlay: () {
                  context.read<CreateProjectBloc>().add(
                        ShowObjectBottomSheetEvent(),
                      );
                },
              );
            }
            if (state.isOpenCategoryBottomSheet) {
              BottomSheetUtils().showCreateProjectInfoSheet(
                context: context,
                title: 'Подробнее о категориях квартир и частных домов',
                height: 350.h,
                mainInformation: categoryInfo,
                removeOverlay: () {
                  context.read<CreateProjectBloc>().add(
                        ShowCategoryBottomSheetEvent(),
                      );
                },
              );
            }
            if (state.isOpenCurrentStateBottomSheet) {
              BottomSheetUtils().showCreateProjectInfoSheet(
                context: context,
                title: 'Подробнее о состояниях объекта',
                height: 650.h,
                mainInformation: currentStateInfo,
                removeOverlay: () {
                  context.read<CreateProjectBloc>().add(
                        ShowCurrentStateBottomSheetEvent(),
                      );
                },
              );
            }
            if (state.isOpenFileBottomSheet) {
              BottomSheetUtils().showCreateProjectFileSheet(
                context: context,
                removeOverlay: () {
                  context.read<CreateProjectBloc>().add(
                        ShowFileBottomSheetEvent(),
                      );
                },
                onTapFile: () {
                  context.read<CreateProjectBloc>().add(
                        ChooseFileEvent(),
                      );
                },
                onTapImage: () {
                  context.read<CreateProjectBloc>().add(
                        ChooseImageEvent(),
                      );
                },
              );
            }
          }
        },
        builder: (BuildContext context, CreateProjectState state) {
          if (state is ShowCreateProjectState) {
            final List<ObjectTypeModel> objectTypes = state.objectTypes;
            if (state.currentPage == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CreateProjectAppbarWidget(percentage: 0),
                    Gap(22.h),
                    Text(
                      'Название проекта или объекта',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    Gap(24.h),
                    DefaultTextFormField(
                      hintText: 'Название или адрес',
                      controller: projectName,
                      isError: isNameEmpty,
                    ),
                    if (isNameEmpty) Gap(8.h),
                    if (isNameEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(16.w),
                          Text(
                            'Сначала введите название',
                            style: AppTypography.caption1Regular.copyWith(
                              color: AppColors.red700,
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (projectName.text.isEmpty) {
                          setState(() {
                            isNameEmpty = true;
                          });
                        } else {
                          isNameEmpty = false;
                          context.read<CreateProjectBloc>().add(
                                CreateProjectNameEvent(
                                  name: projectName.text,
                                ),
                              );
                        }
                      },
                      backgroundColor: AppColors.buttonPrimaryBg,
                      buttonText: 'Далее',
                      textStyle: AppTypography.headlineRegular
                          .copyWith(color: AppColors.buttonPrimaryText),
                    ),
                  ],
                ),
              );
            } else if (state.currentPage == 1) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w).copyWith(
                  top: 57.h,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CreateProjectAppbarWidget(percentage: 0.2),
                          Gap(22.h),
                          Text(
                            'Выберите тип объекта',
                            style: AppTypography.h5Bold
                                .copyWith(color: AppColors.textPrimary),
                          ),
                          if (missingObjectType) Gap(8.h),
                          if (missingObjectType)
                            Text(
                              'Сначала выберите тип объекта',
                              style: AppTypography.caption1Regular.copyWith(
                                color: AppColors.red700,
                              ),
                            ),
                          Gap(24.h),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15.h,
                              crossAxisSpacing: 15.w,
                              mainAxisExtent: 165.h,
                            ),
                            itemCount: objectTypes.length,
                            itemBuilder: (context, index) {
                              return ProjectCardWidget(
                                imageUrl: objectTypes[index].photoDownloadUrl,
                                title: objectTypes[index].name,
                                isSelected:
                                    objectType == objectTypes[index].name,
                                onTap: () {
                                  setState(() {
                                    objectType = objectTypes[index].name;
                                    objectTypeId = objectTypes[index].id;
                                    objectName = objectTypes[index].name;
                                    objectImage =
                                        objectTypes[index].photoDownloadUrl;
                                  });
                                },
                              );
                            },
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                          top: 8.h,
                        ),
                        child: Column(
                          children: [
                            DefaultButtonWidget(
                              onTap: () {
                                if (objectType != '' && objectTypeId != null) {
                                  context.read<CreateProjectBloc>().add(
                                        SelectObjectTypeEvent(
                                          objectTypeId: objectTypeId!,
                                          objectName: objectName!,
                                          objectImage: objectImage!,
                                          projectId: state.projectId,
                                        ),
                                      );
                                } else {
                                  setState(() {
                                    missingObjectType = true;
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
                                context.read<CreateProjectBloc>().add(
                                      ShowObjectBottomSheetEvent(),
                                    );
                              },
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
                ),
              );
            } else if (state.currentPage == 2) {
              final List<ProjectCategoryModel> categories =
                  state.projectCategories;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CreateProjectAppbarWidget(percentage: 0.4),
                    Gap(22.h),
                    Text(
                      'Выберите категорию',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    if (missingCategory) Gap(8.h),
                    if (missingCategory)
                      Text(
                        'Сначала выберите категорию',
                        style: AppTypography.caption1Regular
                            .copyWith(color: AppColors.red700),
                      ),
                    Gap(24.h),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                      separatorBuilder: (BuildContext context, _) {
                        return Gap(16.h);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryButtonWidget(
                          text: categories[index].name,
                          isSelected: category == categories[index].name,
                          onTap: () {
                            setState(() {
                              category = categories[index].name;
                              projectCategoryId = categories[index].id;
                              categoryName = categories[index].name;
                            });
                          },
                        );
                      },
                    ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (category != '' && projectCategoryId != null) {
                          context.read<CreateProjectBloc>().add(
                                SelectCategoryEvent(
                                  projectId: state.projectId,
                                  projectCategoryId: projectCategoryId!,
                                  categoryName: categoryName!,
                                ),
                              );
                        } else {
                          setState(() {
                            missingCategory = true;
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
                        context.read<CreateProjectBloc>().add(
                              ShowCategoryBottomSheetEvent(),
                            );
                      },
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
              );
            } else if (state.currentPage == 3) {
              final List<ObjectConditionModel> objectConditions =
                  state.objectConditions;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.w).copyWith(
                  top: 57.h,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CreateProjectAppbarWidget(percentage: 0.6),
                          Gap(22.h),
                          Text(
                            'Выберите текущее состояние',
                            style: AppTypography.h5Bold
                                .copyWith(color: AppColors.textPrimary),
                          ),
                          if (missingCurrentState) Gap(8.h),
                          if (missingCurrentState)
                            Text(
                              'Сначала выберите текущее состояние',
                              style: AppTypography.caption1Regular.copyWith(
                                color: AppColors.red700,
                              ),
                            ),
                          Gap(24.h),
                          SizedBox(
                            height: 477.h,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15.h,
                                crossAxisSpacing: 15.w,
                                mainAxisExtent: 155.h,
                              ),
                              itemCount: objectConditions.length,
                              itemBuilder: (context, index) {
                                return CurrentStateCardWidget(
                                  image: objectConditions[index].image,
                                  title: objectConditions[index].name,
                                  isSelected: currentStateItem ==
                                      objectConditions[index].name,
                                  onTap: () {
                                    setState(() {
                                      currentStateItem =
                                          objectConditions[index].name;
                                      objectConditionId =
                                          objectConditions[index].id;
                                      objectConditionName =
                                          objectConditions[index].name!;
                                      objectConditionImage =
                                          objectConditions[index].image!;
                                    });
                                  },
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                          top: 8.h,
                        ),
                        child: Column(
                          children: [
                            DefaultButtonWidget(
                              onTap: () {
                                if (currentStateItem != '' &&
                                    objectConditionId != null) {
                                  context.read<CreateProjectBloc>().add(
                                        SelectCurrentStateEvent(
                                          projectId: state.projectId,
                                          objectConditionId: objectConditionId!,
                                          objectConditionName:
                                              objectConditionName!,
                                          objectConditionImage:
                                              objectConditionImage!,
                                        ),
                                      );
                                } else {
                                  setState(() {
                                    missingCurrentState = true;
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
                                context.read<CreateProjectBloc>().add(
                                      ShowCurrentStateBottomSheetEvent(),
                                    );
                              },
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
                ),
              );
            } else if (state.currentPage == 4) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CreateProjectAppbarWidget(percentage: 0.8),
                    Gap(22.h),
                    Text(
                      'Загрузите планы и чертежи\nпри их наличии',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                    if (missingFiles) Gap(8.h),
                    if (missingFiles)
                      Text(
                        'Сначала загрузите файлы',
                        style: AppTypography.caption1Regular
                            .copyWith(color: AppColors.red700),
                        textAlign: TextAlign.center,
                      ),
                    Gap(24.h),
                    state.uploadedFilesAndImages.isNotEmpty
                        ? const PickedFilesWidget()
                        : Container(
                            width: 345.w,
                            height: 160.h,
                            padding: EdgeInsets.only(
                              top: 12.h,
                              bottom: 16.h,
                              left: 12.w,
                              right: 28.w,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.uiBackground,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/ic_mini_map.svg',
                                      width: 24.w,
                                      height: 24.h,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.textPrimary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 273.w,
                                      child: Text(
                                        'Вы можете загрузить техпаспорт, план, чертеж объекта или любые другие файлы',
                                        style: AppTypography.subheadsMedium
                                            .copyWith(
                                                color: AppColors.textPrimary),
                                      ),
                                    ),
                                    Gap(10.h),
                                    Text(
                                      'Поддерживаемые типы файлов:',
                                      style: AppTypography.caption1Regular
                                          .copyWith(
                                              color: AppColors.textPrimary),
                                    ),
                                    Gap(8.h),
                                    SizedBox(
                                      width: 273.w,
                                      child: GridView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7,
                                          mainAxisSpacing: 6.h,
                                          crossAxisSpacing: 4.w,
                                          mainAxisExtent: 20.h,
                                        ),
                                        itemCount: fileTypes.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 20.h,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2.h,
                                              horizontal: 8.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.gray300A18,
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                            ),
                                            child: Text(
                                              fileTypes[index],
                                              style: AppTypography
                                                  .caption1Regular
                                                  .copyWith(
                                                      color: AppColors
                                                          .textPrimary),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    Gap(24.h),
                    DefaultButtonWidget(
                      onTap: () {
                        context.read<CreateProjectBloc>().add(
                              ShowFileBottomSheetEvent(),
                            );
                      },
                      backgroundColor: AppColors.buttonSecondaryBg,
                      buttonText: '',
                      buttonWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Добавить файл',
                            style: AppTypography.headlineRegular
                                .copyWith(color: AppColors.textPrimary),
                          ),
                          Gap(5.h),
                          SvgPicture.asset(
                            'assets/icons/ic_paper_clip.svg',
                            width: 14.w,
                            height: 16.h,
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
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (state.uploadedFilesAndImages.isNotEmpty) {
                          setState(() {
                            missingFiles = false;
                          });
                          context.read<CreateProjectBloc>().add(
                                GoToNextPageEvent(),
                              );
                        } else {
                          setState(() {
                            missingFiles = true;
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
                        context.read<CreateProjectBloc>().add(
                              GoToNextPageEvent(),
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
              );
            } else if (state.currentPage == 5) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CreateProjectAppbarWidget(percentage: 0.9),
                    Gap(22.h),
                    Text(
                      'Общая площадь объекта, м²',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    Gap(24.h),
                    DefaultTextFormField(
                      hintText: 'Общая площадь, м²',
                      controller: totalArea,
                      isError: isAreaEmpty,
                      isNumber: true,
                    ),
                    if (isAreaEmpty) Gap(8.h),
                    if (isAreaEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gap(16.w),
                          Text(
                            'Сначала введите площадь',
                            style: AppTypography.caption1Regular.copyWith(
                              color: AppColors.red700,
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (totalArea.text.isNotEmpty) {
                          context.read<CreateProjectBloc>().add(
                                CreateTechConditionEvent(
                                  area: int.parse(totalArea.text),
                                  projectId: state.projectId,
                                ),
                              );
                          context.read<CreateProjectBloc>().add(
                                GetAllAIAgentsEvent(),
                              );
                        } else {
                          setState(() {
                            isAreaEmpty = true;
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
                        context.read<CreateProjectBloc>().add(
                              GoToNextPageEvent(),
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
              );
            } else if (state.currentPage == 6) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                  bottom: 33.h,
                  top: 57.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CreateProjectAppbarWidget(percentage: 0.9),
                    Gap(22.h),
                    Text(
                      'Хотите подключить ИИ консультантов к проекту?',
                      style: AppTypography.h5Bold
                          .copyWith(color: AppColors.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                    Gap(24.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h)
                              .copyWith(bottom: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.uiBackground,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Подключение ИИ-консультантов упрощает работу, так как позволяет автоматически формировать сметы, анализировать данные и готовить рекомендации для проекта. Это освобождает время для более стратегических задач и помогает избежать ошибок в расчетах.',
                        style: AppTypography.caption1Regular
                            .copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                    if (missingAiConsultants) Gap(8.h),
                    if (missingAiConsultants)
                      Text(
                        'Сначала выберите ИИ консультантов',
                        style: AppTypography.caption1Regular.copyWith(
                          color: AppColors.red700,
                        ),
                      ),
                    Gap(24.h),
                    SizedBox(
                      height: 335.h,
                      child: ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.aiAgents.length,
                          separatorBuilder: (context, _) => Gap(16.h),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (selectedAiConsultants
                                    .contains(state.aiAgents[index])) {
                                  setState(() {
                                    selectedAiConsultants
                                        .remove(state.aiAgents[index]);
                                  });
                                } else {
                                  setState(() {
                                    selectedAiConsultants
                                        .add(state.aiAgents[index]);
                                  });
                                }
                              },
                              child: Container(
                                height: 44.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 9.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(13.r),
                                  border: Border.all(
                                    color: selectedAiConsultants
                                            .contains(state.aiAgents[index])
                                        ? AppColors.gradient1
                                        : AppColors.uiSecondaryBorder,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 13.r,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(66.r),
                                        child: state.aiAgents[index].image !=
                                                null
                                            ? Image.network(
                                                state.aiAgents[index].image!,
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Gap(8.w),
                                    Text(
                                      state.aiAgents[index].name,
                                      style: AppTypography.subheadsMedium
                                          .copyWith(
                                              color: AppColors.textPrimary),
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 16.h,
                                      width: 16.w,
                                      decoration: BoxDecoration(
                                        color: selectedAiConsultants
                                                .contains(state.aiAgents[index])
                                            ? AppColors.gradient1
                                            : AppColors.uiBackground,
                                        borderRadius:
                                            BorderRadius.circular(45.r),
                                        border: Border.all(
                                          color: AppColors.uiSecondaryBorder,
                                        ),
                                      ),
                                      child: selectedAiConsultants
                                              .contains(state.aiAgents[index])
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
                          }),
                    ),
                    const Spacer(),
                    DefaultButtonWidget(
                      onTap: () {
                        if (selectedAiConsultants.isEmpty) {
                          setState(() {
                            missingAiConsultants = true;
                          });
                        } else {
                          context.read<CreateProjectBloc>().add(
                                // GoToNextPageEvent(),
                                AddAiConsultantsEvent(
                                  aiConsultants: selectedAiConsultants,
                                ),
                              );
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
                        context.read<CreateProjectBloc>().add(
                              GoToNextPageEvent(),
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
              );
            }
          }
          if (state is CreateProjectSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w).copyWith(
                bottom: 33.h,
                top: 57.h,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      const CreateProjectAppbarWidget(percentage: 1),
                      const Spacer(),
                      DefaultButtonWidget(
                        onTap: () {
                          context.router.navigate(
                            const HomeWrapperRoute(),
                          );
                        },
                        backgroundColor: AppColors.buttonPrimaryBg,
                        buttonText: 'Завершить',
                        textStyle: AppTypography.headlineRegular
                            .copyWith(color: AppColors.buttonPrimaryText),
                      ),
                      Gap(10.h),
                      DefaultButtonWidget(
                        onTap: () {
                          context.router.replace(
                            const CreateSmetaWrapperRoute(),
                          );
                        },
                        backgroundColor: AppColors.buttonSecondaryBg,
                        buttonText: '',
                        buttonWidget: Text(
                          'Создать смету по проекту',
                          style: AppTypography.headlineRegular
                              .copyWith(color: AppColors.textPrimary),
                          textAlign: TextAlign.center,
                        ),
                        textStyle: AppTypography.headlineRegular,
                        borderColor: AppColors.buttonSecondaryBorder,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lotties/create_project_success.json',
                        width: 200.w,
                        height: 200.h,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Проект успешно создан!',
                        style: AppTypography.h5Bold
                            .copyWith(color: AppColors.textPrimary),
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
    );
  }
}
