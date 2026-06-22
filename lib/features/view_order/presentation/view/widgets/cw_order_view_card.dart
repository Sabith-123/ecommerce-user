import 'package:ecommerce_user_app/features/order_product.dart/data/model/order_model.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CwOrderViewCard extends StatelessWidget {
  final OrderModel orderModel;
  const CwOrderViewCard({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        border: Border.all(
          color: AppColors.blackColor.withOpacity(.05),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: const Color.fromARGB(255, 190, 190, 190),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID :- ${orderModel.orderId}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      orderModel.orderStatus,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Gap(20),
          ListView.builder(
            itemCount: orderModel.items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.subTitleColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text('${orderModel.items[index]['quantity']} X'),
                      ),
                    ),
                    Gap(20),
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        orderModel.items[index]['productName'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(thickness: 2),
          ),
          Gap(5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Ordered: ${orderModel.createdAt != null ? DateFormat('MMM dd,yyyy hh:mm a').format(orderModel.createdAt!.toDate()) : 'Just now'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Spacer(),
                Text(
                  'Bill Total \$ ${orderModel.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          Gap(15),
        ],
      ),
    );
  }
}
