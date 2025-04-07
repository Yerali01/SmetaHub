import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smetahub/core/utils/app_typography.dart';
import 'package:smetahub/core/utils/colors.dart';
import 'package:smetahub/core/widgets/default_text_formfield_widget.dart';

class SingleItemWidget extends StatefulWidget {
  const SingleItemWidget({
    super.key,
    required this.text,
    required this.amount,
    required this.metric,
    required this.onChanged,
    this.readOnly,
  });

  final String text;
  final int amount;
  final String metric;
  final Function(String value) onChanged;
  final bool? readOnly;

  @override
  State<SingleItemWidget> createState() => _SingleItemWidgetState();
}

class _SingleItemWidgetState extends State<SingleItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = '${widget.amount}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
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
            // suffixIcon: Text(widget.metric),
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
}
