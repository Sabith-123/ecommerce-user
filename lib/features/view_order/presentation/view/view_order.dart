import 'package:ecommerce_user_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:ecommerce_user_app/features/order_product.dart/presentation/provider/order_provider.dart';
import 'package:ecommerce_user_app/features/view_order/presentation/view/widgets/cw_order_view_card.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userId = context.read<AuthProvider>().userData?.id;
      if (userId != null) {
        context.read<OrderProvider>().fetchOrderDetailsFun(userId: userId);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('View Order'),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            // 1. Show a loading spinner while fetching from Firebase
            if (orderProvider.isFetchOrderLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            // 2. Show a message if the user has never ordered anything
            if (orderProvider.orderHistoryList.isEmpty) {
              return Center(
                child: Text(
                  'No orders found',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }

            // 3. Show the list
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orderProvider.orderHistoryList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CwOrderViewCard(
                          orderModel: orderProvider.orderHistoryList[index],
                        ),
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
