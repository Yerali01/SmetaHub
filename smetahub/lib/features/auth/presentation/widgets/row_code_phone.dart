import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/features/auth/presentation/bloc/auth_bloc.dart';

class RowCodePhone extends StatefulWidget {
  const RowCodePhone({
    super.key,
    this.isResetPassword = false,
  });

  final bool? isResetPassword;

  @override
  State<RowCodePhone> createState() => _RowCodePhoneState();
}

class _RowCodePhoneState extends State<RowCodePhone> {
  final List<TextEditingController> listController =
      List<TextEditingController>.generate(
    4,
    (int _) {
      return TextEditingController();
    },
  );

  final List<FocusNode> listFocusNode = List<FocusNode>.generate(
    4,
    (int _) {
      return FocusNode();
    },
  );

// Функция которая проверяет "Заполнены ли все поля?".
  void filledField() {
    // Проверка на пустоту всех контролероа
    final bool hasEmptyField = listController.any(
      (TextEditingController controller) => controller.text.isEmpty,
    );
    // Если встретилось пустое поле.
    if (hasEmptyField) {
      // context.read<AuthBloc>().add(
      //       UpdateCodePhoneEvent(),
      //     );
    } else {
      // Если все впорядке.
      final StringBuffer code = StringBuffer();
      // Берем текст с каждого контролера и склеиваем в строку через StringBuffer
      for (final TextEditingController controller in listController) {
        code.write(controller.text);
      }
      FocusScope.of(context).unfocus();
      // так как код уже заполнен, то можно сделать кнопку активной, и передать туда код
      // чтобып потом можно было проверить
      if (widget.isResetPassword == true) {
        context.read<AuthBloc>().add(
              ResetPasswordRowCodeFilledEvent(
                isActive: true,
                code: code.toString(),
              ),
            );
      } else {
        context.read<AuthBloc>().add(
              SignUpRowCodeFilledEvent(
                isActive: true,
                code: code.toString(),
              ),
            );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < listFocusNode.length; i++) {
      listFocusNode[i].addListener(() {
        setState(() {});
      });
      listController[i].addListener(() {
        if (listController[i].text.length == 1 &&
            i < listFocusNode.length - 1) {
          listFocusNode[i].unfocus();
          FocusScope.of(context).requestFocus(listFocusNode[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final FocusNode focusNode in listFocusNode) {
      focusNode.dispose();
    }
    for (final TextEditingController controller in listController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ...List<Widget>.generate(
          listController.length,
          (int index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: 10.w,
                ),
                child: _CodePhoneTextFormField(
                  controller: listController[index],
                  focusNode: listFocusNode[index],
                  onChanged: (String value) {
                    filledField();
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CodePhoneTextFormField extends StatefulWidget {
  const _CodePhoneTextFormField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  State<_CodePhoneTextFormField> createState() =>
      _CodePhoneTextFormFieldState();
}

class _CodePhoneTextFormFieldState extends State<_CodePhoneTextFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<double>(
      begin: 0,
      end: 0.3,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 13.h,
            horizontal: 16.w,
          ),
          focusedBorder: GradientOutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            gradient: const LinearGradient(
              colors: [
                AppColors.gradient1,
                AppColors.gradient2,
              ],
            ),
            width: 1,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: AppColors.inputBorder,
            ),
          ),
          isCollapsed: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        style: AppTypography.headlineBold.copyWith(
          color: AppColors.textPrimary,
        ),
        cursorHeight: 20.h,
        onChanged: widget.onChanged,
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(
            _offsetAnimation.value * 100,
            0,
          ),
          child: child,
        );
      },
    );
  }
}
