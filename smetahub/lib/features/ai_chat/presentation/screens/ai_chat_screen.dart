import 'package:fancy_border/fancy_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:smetahub/core/services/router/app_router.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/ai_chat/domain/message_model.dart';
import 'package:smetahub/features/ai_chat/presentation/widgets/default_icon_button_widget.dart';
import 'package:smetahub/features/home/domain/entity/ai_consultant.dart';
import 'package:smetahub/features/home/presentation/bloc/home_bloc.dart';

import '../bloc/ai_chat_bloc.dart';

@RoutePage()
class AiChatScreen extends StatefulWidget {
  const AiChatScreen({
    super.key,
  });

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  late TextEditingController _messageController;
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _sendMessage({required int? chatId}) {
    if (_messageController.text.trim().isNotEmpty && chatId != null) {
      context.read<AiChatBloc>().add(
            SendMessageEvent(
              chatId: chatId,
              content: _messageController.text.trim(),
            ),
          );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    double aHeight = MediaQuery.of(context).size.height - 250.h;
    return Scaffold(
      backgroundColor: AppColors.uiBackground,
      appBar: _buildAppBar(context),
      body: BlocConsumer<AiChatBloc, AiChatState>(
        listener: (BuildContext context, AiChatState state) {},
        builder: (BuildContext context, AiChatState state) {
          if (state is ShowAiChatState) {
            return SizedBox(
              height: aHeight,
              child: _buildChatBody(state),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomSheet: BlocConsumer<AiChatBloc, AiChatState>(
        listener: (BuildContext context, AiChatState state) {},
        builder: (BuildContext context, AiChatState state) {
          if (state is ShowAiChatState) {
            return _buildBottomInputSheet(
              isTyping: _messageController.text.isNotEmpty,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildChatBody(ShowAiChatState state) {
    double aHeight = MediaQuery.of(context).size.height - 250.h;
    return Column(
      children: [
        SizedBox(
          height: aHeight,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.messages.length,
            itemBuilder: (BuildContext context, int index) {
              final message = state.messages[index];
              return Column(
                children: [
                  _buildMessageItem(message: message),
                  // if (state.isLoading && index == state.messages.length - 1)
                  if (state.isLoading && index == state.messages.length - 1)
                    Gap(24.h),
                  if (state.isLoading && index == state.messages.length - 1)
                    Row(
                      children: [
                        Gap(15.w),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.uiBgPanels,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 12.w,
                          ),
                          width: 46.w,
                          height: 26.h,
                          child: Center(
                            child: Lottie.asset(
                              'assets/lotties/chat_loading.json',
                              width: 22.w,
                              height: 10.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageItem({
    required Message message,
  }) {
    return message.isUserMessage
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 24.h,
                  right: 15.w,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 14.w,
                ),
                constraints: BoxConstraints(maxWidth: 255.w),
                decoration: BoxDecoration(
                  color: AppColors.uiBgPanels,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                  ),
                ),
                child: Text(
                  message.text,
                  style: AppTypography.subheadsRegular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 32.h,
                  left: 15.w,
                  right: 15.w,
                ),
                constraints: BoxConstraints(maxWidth: 345.w),
                decoration: const BoxDecoration(
                  color: AppColors.transparent,
                ),
                child: Text(
                  message.text,
                  style: AppTypography.subheadsRegular.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.uiBgPanels,
      elevation: 0,
      centerTitle: true,
      title: BlocConsumer<AiChatBloc, AiChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ShowAiChatState) {
            return SizedBox(
              height: 90.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const DefaultIconButtonWidget(
                      icon: 'assets/icons/ic_paper_list.svg',
                      iconWidth: 14.31,
                      iconHeight: 17.5,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_logo_brush.svg',
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'SmetaHub',
                        style: AppTypography.headlineMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AiChatBloc>().add(
                            CreateNewChatEvent(
                              title: '',
                              aiAgentId: state.selectedAgentId ??
                                  state.selectedAiAgent!.id,
                            ),
                          );
                    },
                    child: DefaultIconButtonWidget(
                      icon: 'assets/icons/ic_add_chat.svg',
                      iconWidth: 19.w,
                      iconHeight: 19.h,
                    ),
                  ),
                  Gap(8.w),
                  GestureDetector(
                    onTap: () {
                      context.router.navigate(const HomeWrapperRoute());
                    },
                    child: DefaultIconButtonWidget(
                      icon: 'assets/icons/ic_close.svg',
                      iconWidth: 12.w,
                      iconHeight: 12.h,
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBottomInputSheet({
    required bool isTyping,
  }) {
    return BlocBuilder<AiChatBloc, AiChatState>(
      builder: (BuildContext context, AiChatState state) {
        if (state is ShowAiChatState) {
          return Container(
            height: 151.h,
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
              bottom: 38.h,
              top: 24.h,
            ),
            child: Column(
              children: [
                _buildInputField(chatId: state.chatId),
                SizedBox(height: 8.h),
                _buildActionButtons(
                  selectedAiAgent: state.selectedAiAgent,
                  isTyping: isTyping,
                  isLoading: state.isLoading,
                  chatId: state.chatId,
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
                            child: Column(
                              children: [
                                Gap(10.h),
                                Container(
                                  width: 82.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.uiSecondaryBorder,
                                    borderRadius: BorderRadius.circular(26.r),
                                  ),
                                ),
                                Gap(22.h),
                                Text(
                                  'Выберите ИИ консультанта',
                                  style: AppTypography.h5Bold
                                      .copyWith(color: AppColors.textPrimary),
                                ),
                                Gap(36.h),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
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
                                        context.read<AiChatBloc>().add(
                                              SelectChatAiAgentEvent(
                                                aiAgent: state.aiAgents[index],
                                              ),
                                            );
                                        context.router.pop();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 9.h,
                                          horizontal: 16.w,
                                        ),
                                        decoration: isSelected
                                            ? ShapeDecoration(
                                                color: AppColors.transparent,
                                                shape: FancyBorder(
                                                  shape:
                                                      const RoundedRectangleBorder(),
                                                  width: 1,
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      AppColors.gradient1,
                                                      AppColors.gradient2,
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  corners: BorderRadius.all(
                                                    Radius.circular(13.r),
                                                  ),
                                                ),
                                              )
                                            : BoxDecoration(
                                                color: AppColors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(13.r),
                                                border: Border.all(
                                                  color: AppColors
                                                      .uiSecondaryBorder,
                                                ),
                                              ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 13.r,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(38.r),
                                                child: Image.network(
                                                  state.aiAgents[index].image ??
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
                                                    : AppColors.uiBackground,
                                                borderRadius:
                                                    BorderRadius.circular(45.r),
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
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildInputField({required int? chatId}) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/icons/ic_consultant_star.svg',
          width: 16.w,
          height: 16.h,
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: TextFormField(
            maxLines: null,
            textInputAction: TextInputAction.newline,
            controller: _messageController,
            focusNode: _messageFocusNode,
            decoration: InputDecoration(
              hintText: 'Введите, скажите или отправьте файл...',
              hintMaxLines: 1,
              hintStyle: AppTypography.headlineRegular.copyWith(
                color: AppColors.gray100,
              ),
              border: InputBorder.none,
            ),
            onChanged: (String value) {
              setState(() {});
            },
            onFieldSubmitted: (_) => _sendMessage(chatId: chatId),
            style: AppTypography.headlineRegular.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons({
    required AiConsultant? selectedAiAgent,
    required bool isTyping,
    required bool isLoading,
    required int? chatId,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        _buildAiAgentSelector(
          selectedAiAgent: selectedAiAgent,
          onTap: onTap,
        ),
        const Spacer(),
        _buildAttachButton(),
        SizedBox(width: 8.w),
        _buildVoiceRecordButton(
          isTyping: isTyping,
          chatId: chatId,
          isLoading: isLoading,
        ),
      ],
    );
  }

  Widget _buildAiAgentSelector({
    required AiConsultant? selectedAiAgent,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      // onTap: _openAgentSelector,
      onTap: onTap,
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
            if (selectedAiAgent?.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(49.r),
                child: Image.network(
                  selectedAiAgent!.image!,
                  width: 20.w,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(width: 8.w),
            Text(
              'Чат с ${selectedAiAgent?.name}',
              style: AppTypography.subheadsMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 6.w),
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
    );
  }

  Widget _buildAttachButton() {
    return GestureDetector(
      // onTap: _attachFile,
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
    );
  }

  Widget _buildVoiceRecordButton({
    required bool isTyping,
    required bool isLoading,
    required int? chatId,
  }) {
    if (isLoading == true) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: 34.w,
          height: 34.h,
          decoration: BoxDecoration(
            color: AppColors.red700,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.transparent,
                border: Border.all(
                  width: 3.w,
                  color: AppColors.buttonPrimaryText,
                ),
                borderRadius: BorderRadius.circular(5.r),
              ),
              width: 18.w,
              height: 18.h,
            ),
          ),
        ),
      );
    } else if (isTyping) {
      return GestureDetector(
        onTap: () {
          _sendMessage(chatId: chatId);
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
      );
    } else {
      return GestureDetector(
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
      );
    }
  }
}
