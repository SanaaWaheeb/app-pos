import 'package:demo_nfc/config/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.onTap,
      this.customheight,
      this.customwidth,
      this.btnText,
      this.btnColor,
      this.btnshow = false,
      this.btnTextStyle,
      this.borderColor = false,
      this.borderRadius = 20,
      this.btnWidth = false,
      this.bordersColor});

  GestureTapCallback? onTap;
  double? customheight;
  double? customwidth;
  String? btnText;
  bool? btnshow = false;
  Color? btnColor;
  TextStyle? btnTextStyle;
  bool? borderColor = false;
  double borderRadius;
  Color? bordersColor;
  bool btnWidth = false;

  @override
  Widget build(BuildContext context) {
    double widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: customheight,
        width: btnWidth == false ? customwidth ?? widths / 1.2 : null,
        constraints: btnWidth == true
            ? const BoxConstraints(
                maxWidth: 170,
                minWidth: 50,
              )
            : null,
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(
            color: bordersColor != null
                ? bordersColor!
                : borderColor == false
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(btnText ?? "",
              style:
                  btnTextStyle 
              ),
        ),
      ),
    );
  }
}
