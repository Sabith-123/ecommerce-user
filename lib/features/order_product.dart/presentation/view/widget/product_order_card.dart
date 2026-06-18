import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductOrderCard extends StatelessWidget {
  const ProductOrderCard({super.key});

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
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
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
                      Text("product name"),
                      Text('500 g'),
                      Text("\$35"),
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
                            onTap: () {},
                            child: Icon(
                              Icons.remove,
                              color: AppColors.white,
                              size: 25,
                            ),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight(600),
                              color: AppColors.white,
                              fontFamily: 'montserrat',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
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
