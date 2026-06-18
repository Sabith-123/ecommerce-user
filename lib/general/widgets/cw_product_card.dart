import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_app/features/dashbord/presentation/provider/cart_provider.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CwProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productSubtitle;
  final double productPrice;
  final VoidCallback onTapQtyAdd;
  final String orginalPrice;
  final VoidCallback onTapQtyAddButton;
  final VoidCallback onTapQtyRemoveButton;
  final int productQty;
  const CwProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productSubtitle,
    required this.productPrice,
    required this.onTapQtyAdd,
    required this.orginalPrice,
    required this.onTapQtyAddButton,
    required this.onTapQtyRemoveButton,
    required this.productQty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 130,
                placeholder: (context, url) {
                  return Container(
                    color: AppColors.white,
                    child: Center(
                      child: LoadingAnimationWidget.fallingDot(
                        color: AppColors.greenColor,
                        size: 40,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Container(
                  color: AppColors.primarySoftColor,
                  child: Icon(Icons.error),
                ),
              ),
            ),
            Gap(20),
            Text(
              productName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight(600),
                fontFamily: 'montserrat',
              ),
            ),
            Gap(5),
            Text(
              productSubtitle,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight(400),
                fontFamily: 'montserrat',
              ),
            ),
            Gap(10),
            Row(
              children: [
                Text(
                  '\$$productPrice',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight(600),
                    fontFamily: 'montserrat',
                  ),
                ),
                Gap(7),
                Text(
                  '\$$orginalPrice',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                    fontWeight: FontWeight(600),
                    color: AppColors.subTitleColor,
                    fontFamily: 'montserrat',
                  ),
                ),
                Spacer(),
                productQty == 0
                    ? GestureDetector(
                        onTap: onTapQtyAdd,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : Container(
                        width: 75,
                        height: 23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: onTapQtyRemoveButton,
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  productQty.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight(600),
                                    color: AppColors.white,
                                    fontFamily: 'montserrat',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: onTapQtyAddButton,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
