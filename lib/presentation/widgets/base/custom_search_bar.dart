import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatefulWidget {
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
  final String prefixIcon;
  final double prefixSize;
  final bool divider;
  final TextAlign textAlign;
  final TextStyle hintStyle;
  final Color fillColor;
  final double radius;

  const CustomSearchBar(
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
      required this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.prefixSize = 14,
      this.divider = false,
      this.textAlign = TextAlign.start,
      required this.hintStyle,
      this.fillColor = Colors.transparent,
      this.radius = 0});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: widget.textAlign,
          style: satoshiRegularSmall.copyWith(color: AppColors.darkGray),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ]
              : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            isDense: false,
            hintText: widget.hintText,
            fillColor: widget.fillColor,
            hintStyle: widget.hintStyle,
            filled: true,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widget.prefixSize),
                    child: SvgPicture.asset(widget.prefixIcon,
                        height: 20, width: 20),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: _toggle,
                  )
                : null,
          ),
          onSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit(text)
                  : null,
          onChanged: (text) => widget.onChanged(text),
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
