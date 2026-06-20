import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BillSummary extends StatelessWidget {
  final String productName;
  final String variantName;
  final String quantity;
  final String price;

  const BillSummary({
    super.key,
    required this.productName,
    required this.variantName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Gap(5),
            Text(
              '$variantName   ($quantity X \$$price)',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Spacer(),
        Text(
          '\$${int.parse(price) * int.parse(quantity)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
