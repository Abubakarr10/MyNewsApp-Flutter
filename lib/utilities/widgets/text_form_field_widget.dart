import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {

  final TextEditingController ctrl;
  final TextInputType keyType;
  final String returnMessage;
  final String labelText;
  final Color mainColor;
  final String? hintText;
  final String? iconPath;
  final double width;
  final double height;
  final double? borderRadius;
  final double? disabledBorderRadius;
  final double? enabledBorderRadius;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const TextFormFieldWidget({super.key,
    required this.ctrl,
    required this.keyType,
    this.labelText = '',
    this.hintText = '',
    this.returnMessage = 'return message',
    this.iconPath = '',
    this.mainColor = const Color(0XFF7D7245),
    this.height = 60,
    this.width = 100,
    this.marginLeft = 20,
    this.marginRight = 20,
    this.marginTop = 20,
    this.borderRadius = 25,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.disabledBorderRadius = 0,
    this.enabledBorderRadius = 0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      margin:
      EdgeInsets.only(left: marginLeft, right: marginRight, top: marginTop),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          boxShadow:  [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10, offset: const Offset(0, 7),
                spreadRadius: 4
            )
          ]
      ),
      child: Align(
        alignment: FractionalOffset.centerLeft,
        child: TextFormField(
          controller: ctrl,
          cursorColor: Colors.red,
          keyboardType: keyType,
          validator: (value) {
            if (value!.isEmpty) {
              return returnMessage;
            }
            return null;
          },
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusColor: Colors.white,
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(enabledBorderRadius!),
                  borderSide: const BorderSide(
                      color: Colors.white
                  )
              ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(disabledBorderRadius!),
                  borderSide: const BorderSide(
                      color: Colors.white
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius!),
                  borderSide:  const BorderSide(
                      color: Colors.red,
                      width: 2.5
                  )
              ),
              prefixIcon: iconPath == ''? null :
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: SizedBox(width: 15, height: 15, child: Image.asset(iconPath!)),
              ),
              prefixIconColor: mainColor,
              hintStyle:  TextStyle(
                  fontSize: 12,
                  color: mainColor
              ),
              floatingLabelBehavior: floatingLabelBehavior,
              border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius!),
                  borderSide: const BorderSide(
                      color: Colors.white
                  )
              )),
        ),
      ),
    );
  }
}
