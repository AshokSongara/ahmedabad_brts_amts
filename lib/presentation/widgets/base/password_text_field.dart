import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function onChanged;
  final Function onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final double prefixSize;
  final bool divider;
  final TextAlign textAlign;
  final int textLength;
  final TextStyle textStyle;

  const PasswordTextField(
      {this.hintText = 'Write something...',
      required this.controller,
      required this.focusNode,
      required this.nextFocus,
      this.isEnabled = true,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      required this.onSubmit,
      required this.onChanged,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.prefixSize = 17,
      this.divider = false,
      this.textAlign = TextAlign.start,
      this.textLength = 500,
      required this.textStyle});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 17),
          child: TextField(
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightGray),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.lightGray),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),color: AppColors.lightGray,
                  onPressed: _toggle,
                ),
                hintText: widget.hintText,
                hintStyle: satoshiRegular.copyWith(
                    fontSize: 14.sp, color: AppColors.lightGray)),
            maxLines: widget.maxLines,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: widget.textAlign,
            style: widget.textStyle,
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            cursorColor: Theme.of(context).primaryColor,
            textCapitalization: widget.capitalization,
            enabled: widget.isEnabled,
            autofocus: false,
            obscureText: widget.isPassword ? _obscureText : false,

            inputFormatters: widget.inputType == TextInputType.phone
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(widget.textLength),
                  ]
                : null,
            onSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : widget.onSubmit != null
                    ? widget.onSubmit(text)
                    : null,
            onChanged: widget.onChanged(),
          ),
        ),
        widget.divider
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8), child: Divider())
            : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
