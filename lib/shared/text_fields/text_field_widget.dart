import 'package:flutter/material.dart';
import 'package:mechinetest/shared/consrants/colors.dart';

class AuthTextfield extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool isObscure;
  final Function? onChange;
  final FormFieldValidator? validator;
  final bool isEnabled;
  const AuthTextfield(
      {super.key,
      required this.hintText,
      this.keyboardType,
      this.controller,
      this.suffixIcon,
      this.isObscure = false,
      this.onChange,
      this.isEnabled = true,
      this.validator});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        enabled: isEnabled,
        style: const TextStyle(
          color: kBlack,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        obscureText: isObscure,
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onPrimary,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xff8391A1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          suffixIcon: UnconstrainedBox(
              child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: suffixIcon,
          )),
          suffixIconConstraints: const BoxConstraints(maxHeight: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color(0xffE8ECF4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color(0xffE8ECF4),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Color(0xffE8ECF4),
            ),
          ),
        ),
      );
}
