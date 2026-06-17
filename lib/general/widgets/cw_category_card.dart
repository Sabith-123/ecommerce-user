import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CwCategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isGridView;
  const CwCategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    this.isGridView = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.instructionBorderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: isGridView ? 120 : 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primarySoftColor,
                ),
              ),
              Gap(10),
              Text(
                title,
                style: TextStyle(
                  fontSize: isGridView ? 16 : 10,
                  fontWeight: isGridView ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
