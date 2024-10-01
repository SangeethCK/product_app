import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechinetest/features/auth/logic/auth_cubit.dart';
import 'package:mechinetest/features/auth/logic/auth_state.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/app/validator/validator.dart';
import 'package:mechinetest/shared/constants/colors.dart';
import 'package:mechinetest/shared/constants/string_constants.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/snackbars/snackbar.dart';
import 'package:mechinetest/shared/text_fields/text_field_widget.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';
import 'package:mechinetest/shared/widgets/buttons/label_button.dart';
import 'package:mechinetest/shared/widgets/card/app_background_card.dart';
import 'package:mechinetest/shared/widgets/overlay/overlay.dart';
import 'package:mechinetest/shared/widgets/viewer.dart/small_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    final registerFormKey = GlobalKey<FormState>(debugLabel: 'register');

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.signUpFetchStatus == ApiFetchStatus.success) {
            Navigator.pushNamed(context, routeLogin);
            kSnackBar(
              content: StringConstants.registerd,
              success: true,
            );
          }
        },
        child: OverlayLoader(
          child: AppBackgroundCard(
            child: ListView(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: kToolbarHeight + 20,
                  bottom: Platform.isIOS ? 50 : 40),
              children: [
                Align(alignment: Alignment.topLeft, child: logoWidget()),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 35),
                  child: Text(
                    StringConstants.register,
                    style: FontPalette.urbenist16,
                  ),
                ),
                Form(
                  key: registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      authTextfieldLabel(label: StringConstants.name),
                      AuthTextfield(
                        hintText: StringConstants.enterName,
                        controller: name,
                        validator: (value) => Validator.validateIsEmpty(value),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 23),
                        child: authTextfieldLabel(label: StringConstants.email),
                      ),
                      AuthTextfield(
                        hintText: StringConstants.enterYourEmail,
                        controller: email,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 23),
                        child:
                            authTextfieldLabel(label: StringConstants.password),
                      ),
                      AuthTextfield(
                        controller: password,
                        hintText: StringConstants.enterYourPswd,
                        validator: (value) => Validator.validateIsEmpty(value),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 23),
                        child: authTextfieldLabel(
                            label: StringConstants.confirmPswd),
                      ),
                      AuthTextfield(
                        hintText: StringConstants.confirmPswd,
                        validator: (value) {
                          if (value.isEmpty || value.trim() == '') {
                            return '';
                          } else if (value.trim() != password.text.trim()) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        controller: confirmPassword,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.maxFinite,
                child: LabelButton(
                  bgColor: kColorMaterialLight,
                  label: StringConstants.createAccount,
                  onTap: () {
                    if (registerFormKey.currentState?.validate() ?? false) {
                      context.read<AuthCubit>().registerWithEmailPassword(
                          email: email.text, password: password.text);
                    }
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: TextSpan(
                      text: StringConstants.haveAccount,
                      style:
                          FontPalette.urbenist14.copyWith(color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                          text: StringConstants.loginNow,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                          style: FontPalette.urbenist14.copyWith(color: kBlack),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
