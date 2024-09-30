import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/features/auth/logic/auth_cubit.dart';
import 'package:mechinetest/features/auth/logic/auth_state.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/text_fields/text_field_widget.dart';
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.signInFetchStatus == ApiFetchStatus.success) {
            // context.read<HomeCubit>().fetchHomeProducts();
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: kToolbarHeight + 20),
                                child: Center(
                                    child: Image.asset(
                                  'assets/icons/logo copy.png',
                                  width: 90,
                                )),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  'Sign in to your\nAccount',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.2),
                                ),
                              ),
                              SizedBox(
                                height:
                                    0.15 * MediaQuery.of(context).size.height,
                              ),
                              authTextfieldLabel(label: 'Email'),
                              AuthTextfield(
                                controller: email,
                                hintText: 'Enter email',
                              ),
                              5.verticalSpace,
                              authTextfieldLabel(label: 'Password'),
                              AuthTextfield(
                                controller: password,
                                hintText: 'Enter Password',
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 15),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: LabelButton(
                                    label: 'Sign in',
                                    onTap: () {
                                      context
                                          .read<AuthCubit>()
                                          .signInWithEmailPassword(
                                              email: email.text,
                                              password: password.text);
                                    },
                                    bgColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              const Row(
                                children: [
                                  Flexible(
                                      child: Divider(
                                    color: Color(0xffEFEFEF),
                                  )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Or',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                      child: Divider(
                                    color: Color(0xffEFEFEF),
                                  )),
                                ],
                              ),
                            ],
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
