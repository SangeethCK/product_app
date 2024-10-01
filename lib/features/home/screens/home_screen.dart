import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mechinetest/features/cart/logic/cart_cubit.dart';
import 'package:mechinetest/features/cart/logic/cart_state.dart';
import 'package:mechinetest/features/home/logic/home_logic.dart';
import 'package:mechinetest/features/home/logic/home_state.dart';
import 'package:mechinetest/features/home/screens/widgets/product_card.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/appbar/appbar.dart';
import 'package:mechinetest/shared/extension/helper.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/snackbars/snackbar.dart';
import 'package:mechinetest/shared/text_fields/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Helper.afterInit(() {
      context.read<HomeCubit>().fetchHomeProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppbarWidget(logo: true, centerTitle: true, title: 'Home', actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return GestureDetector(
                  onTap: () {
                    context.read<CartCubit>().getCartItems();
                    Navigator.pushNamed(context, routeCart);
                  },
                  child: SvgPicture.asset('assets/icons/cart.svg'));
            },
          ),
        ),
      ]),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state.cartStatus == ApiFetchStatus.success) {
            kSnackBar(
              content: 'Successfully added to cart',
              success: true,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            children: [
              AuthTextfield(
                suffixIcon: SvgPicture.asset('assets/icons/Group 1.svg'),
                hintText: 'Search Category',
                radius: 15,
              ),
              16.verticalSpace,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.homeStatus == ApiFetchStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.homeStatus == ApiFetchStatus.failed) {
                    return Center(child: Text(state.error ?? 'Error occurred'));
                  } else if (state.homeStatus == ApiFetchStatus.success) {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: state.homeList?.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 12.0,
                        ),
                        itemBuilder: (context, index) {
                          final product = state.homeList![index];
                          final imageUrl = product.resourceMediumPath != null &&
                                  product.resourceMediumName != null
                              ? '${product.cdnUrl}${product.resourceMediumPath}${product.resourceMediumName}'
                              : '';

                          return ProductCard(
                            onTap: () {
                              context.read<CartCubit>().addToCart(product);
                            },
                            title: product.productName ?? '',
                            imageUrl: imageUrl,
                            price: product.productPrice.toString(),
                            quantity: product.productQty.toString(),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
