import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/utils/formatters.dart';
import 'package:gradient_borders/gradient_borders.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    required this.controller,
    this.hintText = '',
    this.initialText,
    this.contentPadding,
    this.prefixText,
    this.hintStyle,
    this.labelText,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.style,
    this.validator,
    this.disabled = false,
    this.readOnly = false,
    this.maxHeight,
    this.minLines,
    this.maxLines,
    this.borderRadius = 8,
    this.isPhone = false,
    this.isPassword = false,
    this.hidePassword = false,
    this.isDense = true,
    this.isOnTapOutside = true,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixOnTap,
    this.maxLength,
    this.showBorder = true,
    this.onFocusLost,
    this.width,
    this.height,
    this.labelStyle,
    this.suffixStyle,
    this.errorTextStyle,
    this.borderStyle,
    this.focusedBorderStyle,
    this.enabledBorderStyle,
    this.errorBorderStyle,
    this.focusedErrorBorderStyle,
    this.isError = false,
    this.isNumber = false,
    super.key,
  });

  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final String hintText;
  final String? initialText;
  final String? prefixText;
  final TextStyle? hintStyle;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final bool disabled;
  final bool readOnly;
  final double? maxHeight;
  final int? minLines;
  final int? maxLines;
  final double borderRadius;
  final bool isPhone;
  final bool isPassword;
  final bool hidePassword;
  final bool? isDense;
  final bool? isOnTapOutside;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? suffixOnTap;
  final int? maxLength;
  final bool showBorder;
  final void Function(String)? onFocusLost;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final TextStyle? suffixStyle;
  final TextStyle? errorTextStyle;
  final OutlineInputBorder? borderStyle;
  final OutlineInputBorder? focusedBorderStyle;
  final OutlineInputBorder? enabledBorderStyle;
  final OutlineInputBorder? errorBorderStyle;
  final OutlineInputBorder? focusedErrorBorderStyle;

  final bool? isError;
  final bool? isNumber;
  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late TextEditingController controller;
  final FocusNode _focusNode = FocusNode();
  // bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // controller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        color: widget.showBorder ? AppColors.inputBorder : Colors.transparent,
      ),
    );

    final focusedBorderStyle = GradientOutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      gradient: const LinearGradient(
        colors: [
          AppColors.gradient1,
          AppColors.gradient2,
        ],
      ),
      width: 1,
    );

    final textStyle = widget.style ??
        AppTypography.headlineRegular.copyWith(color: AppColors.textPrimary);

    final hintStyle =
        AppTypography.headlineRegular.copyWith(color: AppColors.purple800);

    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(
        color: AppColors.red700,
      ),
    );

    return Form(
      key: _formKey,
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 44.h,
        child: TextFormField(
          cursorColor: AppColors.textPrimary,
          obscureText: widget.hidePassword,
          obscuringCharacter: '◦',
          focusNode: _focusNode,
          controller: controller,
          onTap: widget.onTap,
          readOnly: widget.readOnly || widget.disabled,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: widget.labelStyle,
            hintText: widget.hintText,
            prefixText: widget.prefixText,
            suffixText: widget.maxLength != null && controller.text.isNotEmpty
                ? '${controller.text.length}/${widget.maxLength}'
                : null,
            hintStyle: widget.hintStyle ?? hintStyle,
            border: widget.isError == true
                ? errorBorder
                : widget.borderStyle ?? borderStyle,
            focusedBorder: widget.isError == true
                ? errorBorder
                : widget.focusedBorderStyle ?? focusedBorderStyle,
            enabledBorder: widget.isError == true
                ? errorBorder
                : widget.enabledBorderStyle ?? borderStyle,
            errorBorder: widget.isError == true
                ? errorBorder
                : widget.isError == true
                    ? errorBorder
                    : widget.errorBorderStyle ?? errorBorder,
            focusedErrorBorder: widget.isError == true
                ? errorBorder
                : widget.focusedErrorBorderStyle ?? errorBorder,
            errorStyle: widget.errorTextStyle ??
                AppTypography.caption1Regular.copyWith(color: AppColors.red700),
            isDense: widget.isDense,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 13.w,
                  vertical: 16.h,
                ),
            prefixIcon: widget.prefixIcon,
            prefixStyle: textStyle,
            suffixStyle: widget.suffixStyle,
            suffixIcon: widget.suffixOnTap != null
                ? GestureDetector(
                    onTap: widget.suffixOnTap,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 13.5.h,
                        bottom: 13.5.h,
                        right: 10.5.w,
                        left: 11.5.w,
                      ),
                      child: _buildSuffixIcon(),
                    ),
                  )
                : null,
          ),
          style: textStyle,
          keyboardType: _getKeyboardType(),
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: _getInputFormatters(),
          onChanged: (value) {
            _formKey.currentState!.validate();
            widget.onChanged?.call(value);
          },
          onFieldSubmitted: (value) {
            if (_formKey.currentState!.validate()) {
              widget.onFieldSubmitted ?? widget.onChanged?.call(value);
            }
          },
          onTapOutside: widget.isOnTapOutside == true
              ? (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  widget.onFocusLost?.call(controller.text);
                }
              : (event) {},
        ),
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.isPassword && widget.hidePassword) {
      return SvgPicture.asset(
        'assets/icons/ic_eye.svg',
        width: 21.w,
        height: 17.h,
        colorFilter: const ColorFilter.mode(
          AppColors.purple800,
          BlendMode.srcIn,
        ),
      );
    }
    if (widget.isPassword && widget.hidePassword == false) {
      return SvgPicture.asset(
        'assets/icons/ic_eye_hide.svg',
        width: 21.w,
        height: 17.h,
        colorFilter: const ColorFilter.mode(
          AppColors.purple800,
          BlendMode.srcIn,
        ),
      );
    }

    return null;
  }

  TextInputType _getKeyboardType() {
    if (widget.isPhone) {
      return TextInputType.phone;
    }
    if (widget.isNumber == true) {
      return TextInputType.number;
    }

    return TextInputType.text;
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.isPhone) {
      return [
        LengthLimitingTextInputFormatter(16),
        FilteringTextInputFormatter.digitsOnly,
        NumberTextInputFormatter(),
      ];
    }
    if (widget.maxLength != null) {
      return [LengthLimitingTextInputFormatter(widget.maxLength)];
    }
    return null;
  }
}
