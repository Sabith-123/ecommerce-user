import 'package:ecommerce_user_app/features/categories/data/model/categorie_model.dart';
import 'package:ecommerce_user_app/features/categories/presentation/provider/categorie_provider.dart';
import 'package:ecommerce_user_app/features/dashbord/presentation/provider/cart_provider.dart';
import 'package:ecommerce_user_app/features/dashbord/presentation/provider/product_provider.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:ecommerce_user_app/general/widgets/cw_category_card.dart';
import 'package:ecommerce_user_app/general/widgets/cw_product_card.dart';
import 'package:ecommerce_user_app/general/widgets/cw_search_box.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Dashbord extends StatefulWidget {
  const Dashbord({super.key});

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProductFun();
      context.read<CategorieProvider>().fetchCategoriesFun();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('DashBoard'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer3<ProductProvider, CategorieProvider, CartProvider>(
          builder:
              (
                context,
                productProvider,
                categorieProvider,
                cartProvider,
                child,
              ) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    CwSearchBox(
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Gap(20),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: categorieProvider.categoriesList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CwCategoryCard(
                            title: categorieProvider.categoriesList[index].name,
                            imageUrl:
                                categorieProvider.categoriesList[index].image,
                            onTap: () {},
                            isGridView: false,
                          );
                        },
                      ),
                    ),
                    Gap(30),
                    Expanded(
                      child: GridView.builder(
                        itemCount: productProvider.productItemsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          return CwProductCard(
                            imageUrl: productProvider
                                .productItemsList[index]
                                .imageUrl,
                            productName: productProvider
                                .productItemsList[index]
                                .productName,
                            productSubtitle: productProvider
                                .productItemsList[index]
                                .variantId,
                            productPrice: productProvider
                                .productItemsList[index]
                                .sellingPrice,
                            orginalPrice: productProvider
                                .productItemsList[index]
                                .mrp
                                .toString(),
                            onTapQtyAdd: () {
                              cartProvider.addToCart(
                                productProvider.productItemsList[index],
                              );
                            },
                            productQty: cartProvider.getQuantity(
                              productProvider.productItemsList[index].id,
                            ),
                            onTapQtyAddButton: () {
                              cartProvider.addToCart(
                                productProvider.productItemsList[index],
                              );
                            },
                            onTapQtyRemoveButton: () {
                              cartProvider.removeFromCart(
                                productProvider.productItemsList[index],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}
