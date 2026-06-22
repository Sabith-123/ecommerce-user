import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductOrderCard extends StatelessWidget {
  final String image;
  final String productName;
  final String price;
  final String variantId;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int quantity;
  const ProductOrderCard({
    super.key,
    required this.image,
    required this.productName,
    required this.price,
    required this.variantId,
    required this.onIncrement,
    required this.onDecrement,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
        border: Border.all(color: AppColors.primarySoftColor, width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 60,
                    width: 60,
                    imageUrl: image,
                    fit: BoxFit.cover,
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
              ),
              const Gap(10),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(productName),
                      Text(variantId),
                      Text('\$$price'),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 95,
                  height: 30,
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
                            onTap: onDecrement,
                            child: Icon(
                              Icons.remove,
                              color: AppColors.white,
                              size: 25,
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight(600),
                              color: AppColors.white,
                              fontFamily: 'montserrat',
                            ),
                          ),
                          GestureDetector(
                            onTap: onIncrement,
                            child: Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
