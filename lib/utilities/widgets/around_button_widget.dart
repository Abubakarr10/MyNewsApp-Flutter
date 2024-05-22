import 'package:flutter/material.dart';

import '../app_text.dart';

class AroundButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final double fontSize;
  final Color bgColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? top;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? showIcon;
  final bool? loading;
  const AroundButtonWidget(
      {super.key,
      required this.widthX,
      required this.title,
      required this.bgColor,
      this.height = 50,
      this.width = 100,
      this.textColor = Colors.white,
      required this.fontSize,
      required this.onTap,
      this.fontWeight,
      this.iconButton = Icons.abc,
      this.showIcon,
      this.loading = false,
      this.top = 1,
        this.borderColor = Colors.red
      });

  final double widthX;
  final IconData iconButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: widthX,
      margin: EdgeInsets.only(left: 20, right: 20, top: top!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: bgColor,
          border: Border.all(color: borderColor!)),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: loading == false
            ? Center(
                child: showIcon == false
                    ? AppText(
                        fontSize: fontSize,
                        textFontWeight: FontWeight.w700,
                        textColor: textColor!,
                        title: title,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            iconButton,
                            color: textColor,
                          ),
                          AppText(
                            fontSize: fontSize,
                            textFontWeight: FontWeight.w700,
                            textColor: textColor!,
                            title: title,
                          ),
                        ],
                      ),
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
