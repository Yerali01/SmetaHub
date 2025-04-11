import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';
import 'package:smetahub/features/user_smetas/presentation/bloc/manage_smeta_bloc/manage_smeta_bloc.dart';

class ManageSingleItemWidget extends StatefulWidget {
  const ManageSingleItemWidget({
    super.key,
    required this.text,
    required this.amount,
    required this.metric,
    required this.onChanged,
    this.readOnly,
  });

  final String text;
  final double amount;
  final String metric;
  final Function(String value) onChanged;
  final bool? readOnly;

  @override
  State<ManageSingleItemWidget> createState() => _ManageSingleItemWidgetState();
}

class _ManageSingleItemWidgetState extends State<ManageSingleItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = formatDouble(widget.amount);
  }

  @override
  void didUpdateWidget(covariant ManageSingleItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      controller.text = formatDouble(widget.amount);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatDouble(double value) {
    if (value.isNaN || value.isInfinite) {
      return '-';
    } else if (value == 0.0) {
      return '0';
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageSmetaBloc, ManageSmetaState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ShowManageSmetaState) {
          return SizedBox(
            height: 31.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: AppTypography.caption1Medium.copyWith(
                    color: AppColors.text635D8A,
                  ),
                ),
                DefaultTextFormField(
                  borderRadius: 8.r,
                  height: 30.h,
                  width: 121.w,
                  showBorder: true,
                  controller: controller,
                  suffixIcon: Text(
                    widget.metric,
                    style: AppTypography.headlineRegular
                        .copyWith(color: AppColors.textPrimary),
                  ),
                  suffixIconPadding: EdgeInsets.symmetric(
                    vertical: 6.h,
                  ),
                  suffixOnTap: () {},
                  suffixStyle: AppTypography.headlineRegular
                      .copyWith(color: AppColors.textPrimary),
                  isNumber: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 16.w,
                  ),
                  onChanged: (String value) {
                    widget.onChanged(value);
                  },
                  onFieldSubmitted: (String value) {
                    widget.onChanged(value);
                  },
                  readOnly: widget.readOnly ?? false,
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
