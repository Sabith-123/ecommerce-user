import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BillSummary extends StatelessWidget {
  const BillSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'milk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Gap(5),
            Text(
              '1 X \$2.5',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Spacer(),
        Text(
          '\$2.5',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
