import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Function()? onTap;
  final Function(String)? onChange;
  final controller;
  final String hintText;
  final bool obscureText;
  final double fieldHeight;
  final double fieldBottom;
  final double fieldWidth;
  final double fieldWidthRight;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final TextInputType inputType;
  final bool enabled;
  final bool onTapDatePicker;
  final String errorText;

  const MyTextField(
      {super.key,
      required this.controller,
      this.hintText = "",
      this.obscureText = false,
      this.fieldBottom = 10,
      this.fieldHeight = 10,
      this.fieldWidth = 8,
      this.fieldWidthRight = 8,
      this.paddingTop = 0,
      this.paddingBottom = 0,
      this.paddingLeft = 25,
      this.paddingRight = 25,
      this.inputType = TextInputType.text,
      this.enabled = true,
      this.onTapDatePicker = false,
      this.onTap,
      this.errorText = "",
      this.onChange
      // this.onTap
      });

  @override
  Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      top: paddingTop,
      bottom: paddingBottom,
      left: paddingLeft,
      right: paddingRight,
    ),
    child: Row(
      children: [
        Flexible(
          child: Container(
            height: 45.0, // Set your desired height here
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              textAlignVertical: TextAlignVertical.center, // Center the text vertically
              keyboardType: inputType,
              enabled: enabled,
              decoration: InputDecoration(
                errorText: errorText == "" ? null : errorText,
                contentPadding: EdgeInsets.symmetric(horizontal: fieldWidth), // Padding for left and right
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 213, 213, 213),
                    width: 0.5,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 195, 160, 20),
                    width: 2.0,
                  ),
                ),
              ),
              validator: (value) => errorText,
              onChanged: onChange,
              onTap: onTap,
            ),
          ),
        ),
      ],
    ),
  );
}
}
