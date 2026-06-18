import 'package:ecommerce_user_app/features/categories/presentation/provider/categorie_provider.dart';
import 'package:ecommerce_user_app/general/utils/app_color.dart';
import 'package:ecommerce_user_app/general/widgets/cw_category_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Categories'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<CategorieProvider>(
          builder: (context, categorieProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(20),
                Center(
                  child: Text(
                    'Choose a category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(30),
                Expanded(
                  child: GridView.builder(
                    itemCount: categorieProvider.categoriesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return CwCategoryCard(
                        title: categorieProvider.categoriesList[index].name,
                        imageUrl: categorieProvider.categoriesList[index].image,
                        onTap: () {},
                        isGridView: true,
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
