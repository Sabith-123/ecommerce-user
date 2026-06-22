import 'package:ecommerce_user_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:ecommerce_user_app/features/dashbord/presentation/provider/cart_provider.dart';
import 'package:ecommerce_user_app/features/order_product.dart/presentation/provider/order_provider.dart';
import 'package:ecommerce_user_app/features/order_product.dart/presentation/view/widget/bill_summary.dart';
import 'package:ecommerce_user_app/features/order_product.dart/presentation/view/widget/product_order_card.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:ecommerce_user_app/general/widgets/cw_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CartOrder extends StatelessWidget {
  const CartOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Your Items')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Column(
                children: [
                  Gap(20),
                  Row(
                    children: [
                      Text(
                        'Your Items',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.instructionBorderColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          child: Text(
                            '${cartProvider.cartItemsList.length} Items',
                          ),
                        ),
                      ),
                    ],
                  ),

                  Gap(20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartProvider.cartItemsList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ProductOrderCard(
                          image: cartProvider
                              .cartItemsList[index]
                              .product
                              .imageUrl,
                          productName: cartProvider
                              .cartItemsList[index]
                              .product
                              .productName,
                          price: cartProvider
                              .cartItemsList[index]
                              .product
                              .sellingPrice
                              .toString(),
                          variantId: cartProvider
                              .cartItemsList[index]
                              .product
                              .variantId,
                          onIncrement: () {
                            cartProvider.addToCart(
                              cartProvider.cartItemsList[index].product,
                            );
                          },
                          onDecrement: () {
                            cartProvider.removeFromCart(
                              cartProvider.cartItemsList[index].product,
                            );
                          },
                          quantity: cartProvider.cartItemsList[index].quantity,
                        ),
                      );
                    },
                  ),
                  Gap(20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bill Summry',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Gap(10),
                          ListView.builder(
                            itemCount: cartProvider.cartItemsList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: BillSummary(
                                  price: cartProvider
                                      .cartItemsList[index]
                                      .product
                                      .sellingPrice
                                      .toString(),
                                  productName: cartProvider
                                      .cartItemsList[index]
                                      .product
                                      .productName,
                                  quantity: cartProvider
                                      .cartItemsList[index]
                                      .quantity
                                      .toString(),
                                  variantName: cartProvider
                                      .cartItemsList[index]
                                      .product
                                      .variantId,
                                ),
                              );
                            },
                          ),
                          Gap(3),
                          Divider(),
                          Gap(3),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$ ${cartProvider.subTotal}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Delivery fee',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${cartProvider.deliveyCharge}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'tax',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${(cartProvider.subTotal * cartProvider.tax) / 100}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Gap(3),
                          Divider(),
                          Gap(3),
                          Row(
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${((cartProvider.subTotal * cartProvider.tax) / 100 + cartProvider.deliveyCharge + cartProvider.subTotal).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(20),
                  CwButton(
                    title: 'Place Order',
                    onTap: () {
                      context.read<OrderProvider>().createOrderFun(
                        userId: context.read<AuthProvider>().userData!.id!,
                        address: 'kozhikode kerala 673601',
                        cartProvider: cartProvider,
                      );
                    },
                    isLoading: context
                        .watch<OrderProvider>()
                        .isCreateOrderLoading,
                  ),
                  Gap(20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
