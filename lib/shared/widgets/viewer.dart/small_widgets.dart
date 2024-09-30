import 'package:flutter/material.dart';

Widget logoWidget({double? width, double? height}) => Image.asset(
      'assets/icons/logo copy.png',
      width: width ?? 110,
    );

Widget authTextfieldLabel({
  required String label,
  Color? color,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: TextStyle(
          color: color ?? const Color(0xff333F49),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

Widget textfieldLabel(
        {required String label,
        required BuildContext context,
        double? topPadding,
        bool isRequired = false}) =>
    Padding(
      padding: EdgeInsets.only(bottom: 8, top: topPadding ?? 20),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (isRequired)
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '*',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.error),
              ),
            ),
        ],
      ),
    );
