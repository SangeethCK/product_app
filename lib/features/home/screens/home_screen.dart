import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mechinetest/features/home/logic/home_logic.dart';
import 'package:mechinetest/features/home/logic/home_state.dart';
import 'package:mechinetest/features/home/screens/widgets/home_product_offer_widget.dart';
import 'package:mechinetest/shared/app/enums/api_fetch_status.dart';
import 'package:mechinetest/shared/appbar/appbar.dart';
import 'package:mechinetest/shared/extension/helper.dart';
import 'package:mechinetest/shared/routes/routes.dart';
import 'package:mechinetest/shared/snackbars/snackbar.dart';

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
      appBar: AppbarWidget(hideLeading: true, title: 'Home', actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, routeCart);
              },
              child: SvgPicture.asset('assets/icons/cart.svg')),
        ),
      ]),
      body: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.cartStatus == ApiFetchStatus.success) {
            kSnackBar(
              content: 'Successfully added to cart',
              success: true,
            );
          }
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.homeStatus == ApiFetchStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.homeStatus == ApiFetchStatus.failed) {
              return Center(child: Text(state.error ?? 'Error occurred'));
            } else if (state.homeStatus == ApiFetchStatus.success) {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: state.homeList?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final product = state.homeList![index];
                  final imageUrl = product.resourceMediumPath != null &&
                          product.resourceMediumName != null
                      ? '${product.cdnUrl}${product.resourceMediumPath}${product.resourceMediumName}'
                      : '';

                  return ProductCard(
                    onTap: () {
                      context.read<HomeCubit>().addToCart(product);
                    },
                    title: product.productName ?? '',
                    imageUrl: imageUrl,
                    price: product.productPrice.toString(),
                    quantity: product.productQty.toString(),
                  );
                },
              );
            } else {
              return const Center(child: Text('No products available'));
            }
          },
        ),
      ),
    );
  }
}
