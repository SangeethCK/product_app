import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/auth/logic/auth_cubit.dart';
import 'package:mechinetest/features/auth/logic/auth_state.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/app/validator/validator.dart';
import 'package:mechinetest/shared/constants/colors.dart';
import 'package:mechinetest/shared/constants/image.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/snackbars/snackbar.dart';
import 'package:mechinetest/shared/text_fields/text_field_widget.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';
import 'package:mechinetest/shared/widgets/buttons/label_button.dart';
import 'package:mechinetest/shared/widgets/card/app_background_card.dart';
import 'package:mechinetest/shared/widgets/overlay/overlay.dart';
import 'package:mechinetest/shared/widgets/viewer.dart/small_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    final loginFormKey = GlobalKey<FormState>(debugLabel: 'login');

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.signInFetchStatus == ApiFetchStatus.success) {
            kSnackBar(
              content: 'Welcome Back',
              success: true,
            );
            Navigator.pushNamed(context, routeHome);
          }
        },
        child: OverlayLoader(
          child: AppBackgroundCard(
              child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Form(
                            key: loginFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: kToolbarHeight + 20),
                                  child: Center(
                                      child: Image.asset(
                                    Assets.logoImage,
                                    width: 90,
                                  )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Text(
                                    'Sign in to your\nAccount',
                                    style: FontPalette.urbenist24,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      0.15 * MediaQuery.of(context).size.height,
                                ),
                                authTextfieldLabel(label: 'Email'),
                                AuthTextfield(
                                  validator: (v) => Validator.validateEmail(v),
                                  controller: email,
                                  hintText: 'Enter email',
                                ),
                                5.verticalSpace,
                                authTextfieldLabel(label: 'Password'),
                                AuthTextfield(
                                  validator: (value) =>
                                      Validator.validateIsEmpty(value),
                                  controller: password,
                                  hintText: 'Enter Password',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, bottom: 15),
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    child: LabelButton(
                                      bgColor: kColorMaterialLight,
                                      label: 'Sign in',
                                      onTap: () {
                                        if (loginFormKey.currentState
                                                ?.validate() ??
                                            false) {
                                          context
                                              .read<AuthCubit>()
                                              .signInWithEmailPassword(
                                                  email: email.text,
                                                  password: password.text);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Flexible(
                                        child: Divider(
                                      color: Color(0xffEFEFEF),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        'Or',
                                        style: FontPalette.urbenist14,
                                      ),
                                    ),
                                    const Flexible(
                                        child: Divider(
                                      color: Color(0xffEFEFEF),
                                    )),
                                  ],
                                ),
                                10.verticalSpace,
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 30),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'Don’t have an account? ',
                                          style: FontPalette.urbenist12
                                              .copyWith(color: kBlack),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: ' Signup Now',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamed(
                                                      context, routeSignUp);
                                                },
                                              style: FontPalette.urbenist12
                                                  .copyWith(
                                                      color: primaryColor),
                                            ),
                                          ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
          )),
        ),
      ),
    );
  }
}
